#pragma once

#include "mlir/Pass/Pass.h"

#include "pmlc/dialect/pml/ir/dialect.h"

namespace pmlc::dialect::pml {

#define GEN_PASS_CLASSES
#include "pmlc/dialect/pml/transforms/passes.h.inc"

} // namespace pmlc::dialect::pml
