// Copyright 2020 Intel Corporation

#pragma once

#include "mlir/Conversion/Passes.h"
#include "mlir/Dialect/Affine/Passes.h"
#include "mlir/Dialect/LLVMIR/Transforms/Passes.h"
#include "mlir/Dialect/Linalg/Passes.h"
#include "mlir/Dialect/SCF/Passes.h"
#include "mlir/Dialect/StandardOps/Transforms/Passes.h"
#include "mlir/Transforms/Passes.h"

#include "mlir-hlo/Dialect/mhlo/transforms/register_passes.h"
#include "mlir-hlo/Transforms/register_passes.h"

#include "pmlc/conversion/linalg_to_pxa/passes.h"
#include "pmlc/conversion/pxa_to_affine/passes.h"
#include "pmlc/conversion/stdx_to_llvm/passes.h"
#include "pmlc/conversion/tile_to_linalg/passes.h"
#include "pmlc/conversion/tile_to_pxa/passes.h"
#include "pmlc/dialect/affinex/transforms/passes.h"
#include "pmlc/dialect/layer/transforms/passes.h"
#include "pmlc/dialect/pml/transforms/passes.h"
#include "pmlc/dialect/pxa/transforms/passes.h"
#include "pmlc/dialect/stdx/transforms/passes.h"
#include "pmlc/dialect/tile/transforms/passes.h"
#include "pmlc/rt/runtime_registry.h"
#include "pmlc/target/x86/passes.h"
#include "pmlc/transforms/passes.h"

// This function may be called to register the MLIR passes with the
// global registry.
// If you're building a compiler, you likely don't need this: you would build a
// pipeline programmatically without the need to register with the global
// registry, since it would already be calling the creation routine of the
// individual passes.
// The global registry is interesting to interact with the command-line tools.
inline void registerAllPasses() {
  //
  // MLIR Core
  //

  // General passes
  mlir::registerTransformsPasses();

  // Conversion passes
  mlir::registerConversionPasses();

  // Dialect passes
  mlir::registerAffinePasses();
  mlir::registerLinalgPasses();
  mlir::LLVM::registerLLVMPasses();
  mlir::registerSCFPasses();
  mlir::registerStandardPasses();

  // XLA
  mlir::mhlo::registerAllMhloPasses();
  mlir::lmhlo::registerAllLmhloPasses();
  mlir::disc_ral::registerAllDiscRalPasses();
  mlir::hlo::registerAllHloPasses();

  //
  // PMLC
  //

  // Conversion passes
  pmlc::conversion::linalg_to_pxa::registerPasses();
  pmlc::conversion::pxa_to_affine::registerPasses();
  pmlc::conversion::stdx_to_llvm::registerPasses();
  pmlc::conversion::tile_to_linalg::registerPasses();
  pmlc::conversion::tile_to_pxa::registerPasses();

  // Dialect passes
  pmlc::dialect::affinex::registerPasses();
  pmlc::dialect::layer::registerPasses();
  pmlc::dialect::pml::registerPasses();
  pmlc::dialect::pxa::registerPasses();
  pmlc::dialect::stdx::registerPasses();
  pmlc::dialect::tile::registerPasses();

  // Target passes
  pmlc::target::x86::registerPasses();

  // Generic transforms
  pmlc::transforms::registerPasses();

  pmlc::rt::registerRuntimes();
}
