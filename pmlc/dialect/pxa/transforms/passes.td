#ifndef __PMLC_DIALECT_PXA_PASSES__
#define __PMLC_DIALECT_PXA_PASSES__

include "mlir/Pass/PassBase.td"

def AffineNormalize : FunctionPass<"pxa-normalize"> {
  let summary = "Normalize affine ops";
  let constructor = "pmlc::dialect::pxa::createAffineNormalizePass()";
  let options = [
    Option<"promote", "promote", "bool",
           /*default=*/"true",
           "Promote the body of 1 trip loops">,
    Option<"denest", "denest", "bool",
           /*default=*/"false",
           "Combine perfectly nested loops">
  ];
}

def AutoTileExample : FunctionPass<"pxa-autotile-example"> {
  let summary = "Tile all dimensions by 10";
  let constructor = "pmlc::dialect::pxa::createAutoTileExamplePass()";
}

def DeallocPlacement : Pass<"pxa-dealloc-placement", "mlir::ModuleOp"> {
  let summary = "Adds deallocs for memref allocs";
  let constructor = "pmlc::dialect::pxa::createDeallocPlacementPass()";
}

def Cache : FunctionPass<"pxa-cache"> {
  let summary = "Cache global memory into local memory";
  let constructor = "pmlc::dialect::pxa::createCachePass()";
  let options = [
    Option<"cacheTag", "cache-tag", "std::string",
           /*default=*/"\"cache\"",
           "Cache loop tag to be set">,
    Option<"inputTag", "input-tag", "std::string",
           /*default=*/"\"input\"",
           "Input cache loop tag">,
    Option<"outputTag", "output-tag", "std::string",
           /*default=*/"\"output\"",
           "Output cache loop tag">,
    Option<"outerTag", "outer-tag", "std::string",
           /*default=*/"\"outer\"",
           "Outer loop tag">,
    Option<"middleTag", "middle-tag", "std::string",
           /*default=*/"\"middle\"",
           "Middle loop tag">,
    Option<"innerTag", "inner-tag", "std::string",
           /*default=*/"\"inner\"",
           "Inner loop tag">,
    Option<"wholeBlock", "whole-block", "bool",
           /*default=*/"false",
           "Whether cache the whole memory block">
  ];
  let dependentDialects = ["mlir::memref::MemRefDialect"];
}

def ConvertMemOp : FunctionPass<"pxa-convert-mem-op"> {
  let summary = "Convert standard memory operations to pxa if possible";
  let constructor = "pmlc::dialect::pxa::createConvertMemOpPass()";
}

def Fusion : FunctionPass<"pxa-fusion"> {
  let summary = "Fuse blocks that are compatible";
  let constructor = "pmlc::dialect::pxa::createFusionPass()";
  let options = [
    Option<"memoryActivityThreshold", "mem-threshold", "int64_t",
           /*default=*/"0",
           "Prevent over-fusion by specifying the maximum memory activity "
           "(alloc, read, write) allowed">,
    Option<"minimumThreads", "minimum-threads", "int64_t",
           /*default=*/"0",
           "The minimum number of threads, i.e., the ranges' product of outermost loop."
           "0 for unlimited.">,
    Option<"exactlyMatch", "exactly-match", "bool",
           /*default=*/"false",
           "Whether fuse the loops with exactly matched indices">,
    Option<"tiledFusion", "tiled-fusion", "bool",
           /*default=*/"false",
           "Perform tiled fusions">,
    Option<"loopDepth", "loop-depth", "int64_t",
           /*default=*/"0",
           "How deep the fusion should perform">,
    Option<"singleOutput", "single-output", "bool",
           /*default=*/"false",
           "Allow single output only">,
    Option<"avoidReductionIndexes", "avoid-reduction-indexes", "bool",
           /*default*/"true",
           "Avoid fusion on reduction indexes">
  ];
}

def GPUThread : FunctionPass<"pxa-gpu-thread"> {
  let summary = "Tile outmost loops for GPU threading";
  let constructor = "pmlc::dialect::pxa::createGPUThreadPass()";
  let options = [
    Option<"maxThreads", "max-threads", "unsigned", /*default=*/"64",
           "Set maximum/goal inner threads">
  ];
}

def CPUThread : FunctionPass<"pxa-cpu-thread"> {
  let summary = "Tile outmost loops for CPU threading";
  let constructor = "pmlc::dialect::pxa::createCPUThreadPass()";
  let options = [
    Option<"threads", "threads", "unsigned",
           /*default=*/"std::thread::hardware_concurrency()",
           "Set maximum/goal inner threads">
  ];
}

def Localize : FunctionPass<"pxa-localize"> {
  let summary = "Push memref allocs to innermost scope";
  let constructor = "pmlc::dialect::pxa::createLocalizePass()";
}

def MemRefDataFlowOpt : FunctionPass<"pxa-dataflow-opt"> {
  let summary = "Perform reduce/load forwarding for memrefs";
  let constructor = "pmlc::dialect::pxa::createMemRefDataFlowOptPass()";
    let options = [
    Option<"onlyParallelNested", "only-parallel-nested", "bool",
           /*default=*/"false",
           "Perform memref optimizations only under AffineParallel's scope.">,
  ];
}

def NestLoops : FunctionPass<"pxa-nest-loops"> {
  let summary = "Nests outermost loops to a minimum IV count";
  let constructor = "pmlc::dialect::pxa::createNestLoopsPass()";
  let options = [
    Option<"minLoopIVs", "ivs", "unsigned", /*default=*/"2",
           "Set minimum required IV's">
  ];
}

def ResizeTmps : FunctionPass<"pxa-resize-tmps"> {
  let summary = "Resize temporary buffers to minimal sizes";
  let constructor = "pmlc::dialect::pxa::createResizeTmpsPass()";
  let options = [
  Option<"onlyParallelNested", "only-parallel-nested", "bool",
         /*default=*/"false",
         "Perform resize tmp optimizations only under AffineParallel's scope.">,
  ];
}

def Subgroups : FunctionPass<"pxa-subgroups"> {
  let summary = "Regorganize top level block to maximum use of subgroups on gen9";
  let constructor = "pmlc::dialect::pxa::createSubgroupsPass()";
  let dependentDialects = ["mlir::vector::VectorDialect"];
}

def TestIndirectUsesIterator : Pass<"pxa-test-indirect-uses-iterator"> {
  let summary = "Trace the IndirectUsesIterator";
  let constructor = "pmlc::dialect::pxa::createTestIndirectUsesIteratorPass()";
}

def TestIndirectValuesIterator : Pass<"pxa-test-indirect-values-iterator"> {
  let summary = "Trace the IndirectValuesIterator for unit tests";
  let constructor = "pmlc::dialect::pxa::createTestIndirectValuesIteratorPass()";
}

def TestStrideInfo : Pass<"pxa-stride-info"> {
  let summary = "Report stride data for all loads/stores for unit tests";
  let constructor = "pmlc::dialect::pxa::createTestStrideInfoPass()";
}

def TileAccumulate : FunctionPass<"pxa-tile-accumulate"> {
  let summary = "Tile accumulation indexes into an inner block to avoid "
    "possible race conditions";
  let constructor = "pmlc::dialect::pxa::createTileAccumulatePass()";
}

def Vectorize : FunctionPass<"pxa-vectorize"> {
  let summary = "Perform vectorization based on specified strategy";
  let constructor = "pmlc::dialect::pxa::createVectorizePass()";
  let dependentDialects = ["mlir::vector::VectorDialect"];
  let options = [
    Option<"strategy", "strategy", "std::string",
           "\"simple\"", "Strategy to use for vectorization">,
    Option<"vectorWidth", "width", "unsigned", /*default=*/"8",
           "Vector register size in elements">
  ];
}

def SimplifyArithmetic : FunctionPass<"pxa-simplify-arithmetic"> {
  let summary = "Simplifies arithmetic";
  let constructor = "pmlc::dialect::pxa::createSimplifyArithmeticPass()";
}

def VectorizeMem : FunctionPass<"pxa-vectorize-mem"> {
  let summary = "Vectorize load and reduce assign ops";
  let constructor = "pmlc::dialect::pxa::createVectorizeMemPass()";
  let dependentDialects = ["mlir::vector::VectorDialect"];
}

#endif // __PMLC_DIALECT_PXA_PASSES__
