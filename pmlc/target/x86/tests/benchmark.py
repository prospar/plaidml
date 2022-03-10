import csv
import os
import re
import shutil
import sys
import tempfile


def sed_inplace(filename, pattern, repl):
    '''
    Perform the pure-Python equivalent of in-place `sed` substitution: e.g.,
    `sed -i -e 's/'${pattern}'/'${repl}' "${filename}"`.
    '''
    # For efficiency, precompile the passed regular expression.
    pattern_compiled = re.compile(pattern)

    # For portability, NamedTemporaryFile() defaults to mode "w+b" (i.e., binary
    # writing with updating). This is usually a good thing. In this case,
    # however, binary writing imposes non-trivial encoding constraints trivially
    # resolved by switching to text writing. Let's do that.
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as tmp_file:
        with open(filename) as src_file:
            for line in src_file:
                tmp_file.write(pattern_compiled.sub(repl, line))

    # Overwrite the original file with the munged temporary file in a
    # manner preserving file attributes (e.g., permissions).
    shutil.copystat(filename, tmp_file.name)
    shutil.move(tmp_file.name, filename)


def calcInputDim(o, f, s):
    return (o - 1) * s + f


def getShapeFromDims(dims):
    shape = ""
    for d in dims:
        shape += str(d)
        shape += "x"
    shape += "f32"
    return shape


def getInputMap(reordered, stride):
    map = ""
    if reordered:
        map = "(d0, d1, d2, d3, d4, d5, d6, d7, d8)"
        map += " -> "
        map += "(d0, d8, d1 * " + str(stride) + " + d4,"
        map += " d2 * " + str(stride) + " + d5, d6)"
    else:
        map = "(n, h, w, c, r, s, k)"
        map += " -> "
        map += "(n, h * " + str(stride) + " + r,"
        map += " w * " + str(stride) + " + s, k)"
    return map


def prepareRunTest(bench, vals, testfile, reordered, blockSize):
    finalmlir = "temp.mlir"
    finalllvm = "temp.ll"
    os.system("cp " + testfile + " " + finalmlir)
    pseudoBS = blockSize
    if not vals["REORDER"]:
        pseudoBS = 1

    if reordered:
        perf = "logs/" + bench + '.' + vals["LAYER"] + '.' + str(blockSize) + ".REO"
        key = "REO"
        pass_index = 2
    else:
        perf = "logs/" + bench + '.' + vals["LAYER"] + '.' + str(blockSize) + ".ORG"
        key = "ORG"
        pass_index = 0

    tensors = ["INPUT", "FILTER", "OUTPUT"]
    objs = ["DIM", "SHAPE", "MAP"]
    passes = [
        " -x86-reorder-layouts", " -cse", " -convert-linalg-to-pxa", " -convert-pxa-to-affine",
        " -x86-stage3", " -x86-stage4"
    ]

    for tensor in tensors:
        for obj in objs:
            pattern = "__" + tensor + "_" + obj + "__"
            repl = vals[tensor + "_" + key + "_" + obj]
            sed_inplace(finalmlir, pattern, repl)

    cmd = "pmlc-opt-" + str(pseudoBS)
    for pass_ in passes[pass_index:]:
        cmd += pass_
    cmd += " " + finalmlir + " > " + finalllvm
    os.system(cmd)

    pattern = "llvm.call @print_memref_f32\("
    repl = "// llvm.call @print_memref_f32\("
    sed_inplace(finalllvm, pattern, repl)

    cmd = 'perf stat -x, -d -d -d -o ' + perf + ' -- pmlc-jit -e prospar ' + finalllvm
    os.system(cmd)

    res = {}
    with open(perf, 'r') as f:
        l = f.readlines()
        for x in l:
            z = x.split(",")
            if "task-clock" in z:
                res["task-clock"] = float(z[0])
            if "context-switches" in z:
                res["context-switches"] = int(z[0])
            if "cpu-migrations" in z:
                res["cpu-migrations"] = int(z[0])
            if "page-faults" in z:
                res["page-faults"] = int(z[0])
            if "cycles" in z:
                res["cycles"] = int(z[0])
            if "instructions" in z:
                res["instructions"] = int(z[0])
            if "branches" in z:
                res["branches"] = int(z[0])
            if "branch-misses" in z:
                res["branch-misses"] = int(z[0])

    os.remove(finalllvm)
    os.remove(finalmlir)
    return res


def parserow(row, blockSize):
    vals = {}
    vals["LAYER"] = row["Layer name"]

    vals["ORG_TIMES"] = []
    vals["ORG_CTXSW"] = []
    vals["ORG_CPUMI"] = []
    vals["ORG_PGFLT"] = []
    vals["ORG_CYCLE"] = []
    vals["ORG_INSTR"] = []
    vals["ORG_BRNCH"] = []
    vals["ORG_BRMIS"] = []

    vals["REO_TIMES"] = []
    vals["REO_CTXSW"] = []
    vals["REO_CPUMI"] = []
    vals["REO_PGFLT"] = []
    vals["REO_CYCLE"] = []
    vals["REO_INSTR"] = []
    vals["REO_BRNCH"] = []
    vals["REO_BRMIS"] = []

    vals["REORDER"] = True
    stride = int(row[" Strides"].strip())

    FMAP = "(n, h, w, c, r, s, k) -> (r, s, k, c)"
    RFMAP = "(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d8, d7, d4, d5, d6, d3)"
    OMAP = "(n, h, w, c, r, s, k) -> (n, h, w, c)"
    ROMAP = "(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d7, d1, d2, d3)"

    out_batches = 1
    out_height = int(row[" IFMAP Height"].strip())
    out_width = int(row[" IFMAP Width"].strip())
    out_channels = int(row[" Num Filter"].strip())

    fil_height = int(row[" Filter Height"].strip())
    fil_width = int(row[" Filter Width"].strip())
    fil_channels = int(row[" Channels"].strip())
    fil_numfilters = out_channels

    inp_batches = 1
    inp_height = calcInputDim(out_height, fil_height, stride)
    inp_width = calcInputDim(out_width, fil_width, stride)
    inp_channels = fil_channels

    vals["N"] = 1
    vals["H"] = out_height
    vals["W"] = out_width
    vals["C"] = fil_channels
    vals["R"] = fil_height
    vals["S"] = fil_width
    vals["K"] = fil_numfilters

    if (inp_channels % blockSize != 0) or (out_channels % blockSize != 0):
        vals["REORDER"] = False
        # return vals

    indims = [inp_batches, inp_height, inp_width, inp_channels]
    vals["INPUT_ORG_DIM"] = str(indims)
    vals["INPUT_ORG_SHAPE"] = getShapeFromDims(indims)
    vals["INPUT_ORG_MAP"] = getInputMap(reordered=False, stride=stride)

    rindims = [inp_batches, int(inp_channels / blockSize), inp_height, inp_width, blockSize]
    vals["INPUT_REO_DIM"] = str(rindims)
    vals["INPUT_REO_SHAPE"] = getShapeFromDims(rindims)
    vals["INPUT_REO_MAP"] = getInputMap(reordered=True, stride=stride)

    fdims = [fil_height, fil_width, fil_channels, fil_numfilters]
    vals["FILTER_ORG_DIM"] = str(fdims)
    vals["FILTER_ORG_SHAPE"] = getShapeFromDims(fdims)
    vals["FILTER_ORG_MAP"] = FMAP

    rfdims = [
        int(fil_channels / blockSize),
        int(fil_numfilters / blockSize), fil_height, fil_width, blockSize, blockSize
    ]
    vals["FILTER_REO_DIM"] = str(rfdims)
    vals["FILTER_REO_SHAPE"] = getShapeFromDims(rfdims)
    vals["FILTER_REO_MAP"] = RFMAP

    odims = [out_batches, out_height, out_width, out_channels]
    vals["OUTPUT_ORG_DIM"] = str(odims)
    vals["OUTPUT_ORG_SHAPE"] = getShapeFromDims(odims)
    vals["OUTPUT_ORG_MAP"] = OMAP

    rodims = [out_batches, int(out_channels / blockSize), out_height, out_width, blockSize]
    vals["OUTPUT_REO_DIM"] = str(rodims)
    vals["OUTPUT_REO_SHAPE"] = getShapeFromDims(rodims)
    vals["OUTPUT_REO_MAP"] = ROMAP

    return vals


if __name__ == "__main__":
    benchpath = sys.argv[1]
    if not (os.path.exists(benchpath) and os.path.isdir(benchpath)):
        sys.exit("Path to Benchmarks Incorrect")
    blockSizes = [8, 16, 32, 64]
    repeat = 3

    benchmarks = os.listdir(benchpath)
    for bench in benchmarks:
        data = {}
        statsfile = "logs/" + bench[:-4] + ".log.csv"
        for blockSize in blockSizes:
            path = os.path.join(benchpath, bench)
            headers = False
            data[blockSize] = []
            i = 0

            with open(path, 'r') as datafile:
                reader = csv.DictReader(datafile)
                for row in reader:
                    vals = parserow(row, blockSize)
                    ############################
                    # print(vals["LAYER"], end=',')
                    # print(vals["N"], end=',')
                    # print(vals["H"], end=',')
                    # print(vals["W"], end=',')
                    # print(vals["C"], end=',')
                    # print(vals["R"], end=',')
                    # print(vals["S"], end=',')
                    # print(vals["K"])
                    ############################
                    for iter in range(repeat):
                        if not vals["REORDER"]:
                            res = prepareRunTest(bench, vals, "test1.1.mlir", False, blockSize)
                            vals["ORG_TIMES"].append(res["task-clock"])
                            vals["ORG_CTXSW"].append(res["context-switches"])
                            vals["ORG_CPUMI"].append(res["cpu-migrations"])
                            vals["ORG_PGFLT"].append(res["page-faults"])
                            vals["ORG_CYCLE"].append(res["cycles"])
                            vals["ORG_INSTR"].append(res["instructions"])
                            vals["ORG_BRNCH"].append(res["branches"])
                            vals["ORG_BRMIS"].append(res["branch-misses"])

                            i += 2
                            print(f'%s (bs=%s):[%s]' % (bench[:-4], str(blockSize), "*" * i),
                                  end='\r')

                            vals["REO_TIMES"].append(None)
                            vals["REO_CTXSW"].append(None)
                            vals["REO_CPUMI"].append(None)
                            vals["REO_PGFLT"].append(None)
                            vals["REO_CYCLE"].append(None)
                            vals["REO_INSTR"].append(None)
                            vals["REO_BRNCH"].append(None)
                            vals["REO_BRMIS"].append(None)
                        else:
                            res = prepareRunTest(bench, vals, "test1.1.mlir", False, blockSize)
                            vals["ORG_TIMES"].append(res["task-clock"])
                            vals["ORG_CTXSW"].append(res["context-switches"])
                            vals["ORG_CPUMI"].append(res["cpu-migrations"])
                            vals["ORG_PGFLT"].append(res["page-faults"])
                            vals["ORG_CYCLE"].append(res["cycles"])
                            vals["ORG_INSTR"].append(res["instructions"])
                            vals["ORG_BRNCH"].append(res["branches"])
                            vals["ORG_BRMIS"].append(res["branch-misses"])
                            i += 1
                            print(f'%s (bs=%s):[%s]' % (bench[:-4], str(blockSize), "*" * i),
                                  end='\r')

                            res = prepareRunTest(bench, vals, "test1.2.mlir", True, blockSize)
                            vals["REO_TIMES"].append(res["task-clock"])
                            vals["REO_CTXSW"].append(res["context-switches"])
                            vals["REO_CPUMI"].append(res["cpu-migrations"])
                            vals["REO_PGFLT"].append(res["page-faults"])
                            vals["REO_CYCLE"].append(res["cycles"])
                            vals["REO_INSTR"].append(res["instructions"])
                            vals["REO_BRNCH"].append(res["branches"])
                            vals["REO_BRMIS"].append(res["branch-misses"])
                            i += 1
                            print(f'%s (bs=%s):[%s]' % (bench[:-4], str(blockSize), "*" * i),
                                  end='\r')

                    data[blockSize].append(vals)
            print("")

        outputLines = []
        perfstats = ["CTXSW", "CPUMI", "PGFLT", "CYCLE", "INSTR", "BRNCH", "BRMIS"]
        for i in range(len(data[blockSizes[0]])):
            line = data[blockSizes[0]][i]["LAYER"] + ','
            for bs in blockSizes:
                val = data[bs][i]
                if not val["REORDER"]:
                    org_avg = sum(val["ORG_TIMES"]) / len(val["ORG_TIMES"])
                    line += str(org_avg) + ",None,None,"
                else:
                    org_avg = sum(val["ORG_TIMES"]) / len(val["ORG_TIMES"])
                    reo_avg = sum(val["REO_TIMES"]) / len(val["REO_TIMES"])
                    line += str(org_avg) + ',' + str(reo_avg) + ','
                    line += str(org_avg / reo_avg) + ','
            for bs in blockSizes:
                val = data[bs][i]
                if not val["REORDER"]:
                    for p in perfstats:
                        line += str(sum(val["ORG_" + p]) / len(val["ORG_" + p]))
                        line += ",None,"
                else:
                    for p in perfstats:
                        line += str(sum(val["ORG_" + p]) / len(val["ORG_" + p]))
                        line += ','
                        line += str(sum(val["REO_" + p]) / len(val["REO_" + p]))
                        line += ','
            line += '\n'
            outputLines.append(line)

        print(outputLines)
        print(statsfile)
        cf = open(statsfile, 'w')
        cf.writelines(outputLines)
        cf.close()
        # original_stdout = sys.stdout
        # with open(statsfile, 'w') as csvfile:
        #     csvfile.writelines(outputLines)
