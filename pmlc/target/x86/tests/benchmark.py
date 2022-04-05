import configparser
import csv
import math
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


def calcOutputDim(i, f, s):
    return int((i - f) / s) + 1


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
    outfile = "temp.out"
    os.system("cp " + testfile + " " + finalmlir)

    pseudoBS = blockSize
    while pseudoBS > 1:
        if (vals["C"] % pseudoBS) or (vals["K"] % pseudoBS):
            pseudoBS = int(pseudoBS / 2)
        else:
            break

    if reordered:
        key = "REO"
        pass_index = 2
    else:
        key = "ORG"
        pass_index = 0

    tensors = ["INPUT", "FILTER", "OUTPUT"]
    objs = ["DIM", "SHAPE", "MAP"]
    passes = [
        " -x86-reorder-layouts", " -cse", " -convert-linalg-to-pxa", " -x86-profile-kernels",
        " -convert-pxa-to-affine", " -x86-stage3", " -x86-stage4"
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

    cmd = 'pmlc-jit -e prospar ' + finalllvm + ' > ' + outfile
    os.system(cmd)

    f = open(outfile, 'r')
    lines = f.readlines()
    line = lines[-1]
    usecs = float(line.split(',')[-1][:-1])
    f.close()

    os.remove(finalllvm)
    os.remove(finalmlir)
    os.remove(outfile)
    return usecs * 1000  # output milliseconds


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

    stride = int(row[" Strides"].strip())

    FMAP = "(n, h, w, c, r, s, k) -> (r, s, k, c)"
    RFMAP = "(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d8, d7, d4, d5, d6, d3)"
    OMAP = "(n, h, w, c, r, s, k) -> (n, h, w, c)"
    ROMAP = "(d0, d1, d2, d3, d4, d5, d6, d7, d8) -> (d0, d7, d1, d2, d3)"

    inp_batches = 1
    inp_height = int(row[" IFMAP Height"].strip())
    inp_width = int(row[" IFMAP Width"].strip())
    inp_channels = int(row[" Channels"].strip())

    fil_height = int(row[" Filter Height"].strip())
    fil_width = int(row[" Filter Width"].strip())
    fil_channels = inp_channels
    fil_numfilters = int(row[" Num Filter"].strip())

    out_batches = 1
    out_height = calcOutputDim(inp_height, fil_height, stride)
    out_width = calcOutputDim(inp_width, fil_width, stride)
    out_channels = fil_numfilters

    vals["N"] = 1
    vals["H"] = out_height
    vals["W"] = out_width
    vals["C"] = fil_channels
    vals["R"] = fil_height
    vals["S"] = fil_width
    vals["K"] = fil_numfilters

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

    test = sys.argv[1]
    config = configparser.ConfigParser()
    config.read('opts.cfg')
    config = config[test]
    benchdir = config['BENCHDIR']
    blist = config['BENCHES'].split(',')
    benchmarks = [b for b in os.listdir(benchdir) if b in blist]
    repeat = int(config['REPEAT'])
    iters = int(config['ITERS'])
    warmup = int(config['WARMUP'])
    blockSizes = [int(bs) for bs in config['BLOCKSIZES'].split(',')]
    mode = config['MODE']

    for bench in benchmarks:
        bf = os.path.join(benchdir, bench)
        sf = 'logs/' + bench[:-4] + '.log.csv'
        with open(bf, 'r') as benchfile, open(sf, 'w') as statsfile:
            reader = csv.DictReader(benchfile)
            for row in reader:
                if mode == "printdims":
                    vals = parserow(row, blockSizes[0])
                    print(vals["LAYER"], end=',')
                    print(vals["N"], end=',')
                    print(vals["H"], end=',')
                    print(vals["W"], end=',')
                    print(vals["C"], end=',')
                    print(vals["R"], end=',')
                    print(vals["S"], end=',')
                    print(vals["K"])
                elif mode == "runtests":
                    data = {}
                    for bs in blockSizes:
                        data[bs] = {"ORG": [], "REO": []}

                    for rep in range(repeat):
                        for bs in blockSizes:
                            vals = parserow(row, bs)
                            prog = ""
                            for iter in range(iters + warmup):
                                res = prepareRunTest(bench, vals, "test1.1.mlir", False, bs)
                                if iter >= warmup:
                                    data[bs]["ORG"].append(res)

                                res = prepareRunTest(bench, vals, "test1.2.mlir", True, bs)
                                if iter >= warmup:
                                    data[bs]["REO"].append(res)

                                prog += '*'
                                print(f'%s\t%s\tRepeat=%d\tbs=%d\t%s' %
                                      (bench[:-4], vals["LAYER"], rep + 1, bs, prog),
                                      end='\r')
                            print("")

                    # write down the stats in csv format
                    outline = vals["LAYER"] + ","
                    for bs in blockSizes:
                        oc = data[bs]["ORG"]
                        rc = data[bs]["REO"]
                        outline += str(sum(oc) / len(oc)) + ','
                        outline += str(sum(rc) / len(rc)) + ','
                    statsfile.write(outline + '\n')
