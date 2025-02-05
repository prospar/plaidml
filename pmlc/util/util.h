// Copyright 2019, Intel Corporation

#pragma once

#include <string>
#include <vector>

#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/FormatVariadic.h"

#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/OperationSupport.h"

#include "pmlc/util/logging.h"

namespace pmlc::util {

uint64_t getByteSize(mlir::MemRefType type);

// Pack function arguments to an i8** pointer
void wrapFunctionAndPackArguments(llvm::Module *module,
                                  llvm::StringRef funcName,
                                  llvm::StringRef newName);

// A diagnostic tool for searching for problematic transformations in passes.
// Example usage:
//   DiagnosticCounter counter;
//   for (auto op : func.getOps<SomeOp>()) {
//     auto result = counter.next();
//     if (result == DiagnosticCounter::Result::Break)
//       continue;
//     if (result == DiagnosticCounter::Result::Match)
//       IVLOG(0, "match: " << debugString(*fuseA));
//     // Do transformation as normal
//   }
// Use the PLAIDML_COUNTER environment variable to define the threshold where
// the counter will return Break. When the counter reaches the threshold
// excatly, Match is returned.
struct DiagnosticCounter {
  enum Result {
    Break,
    Continue,
    Match,
  };

  DiagnosticCounter();
  Result next();

  size_t counter;
  size_t threshold;
};

mlir::AffineValueMap getRangesValueMap(mlir::AffineParallelOp op);

void splitAffineMaps(mlir::AffineMap from,
                     mlir::SmallVectorImpl<mlir::AffineMap> &into);

} // namespace pmlc::util

namespace llvm {

template <class T>
inline std::ostream &operator<<(std::ostream &os, const SmallVectorImpl<T> &x) {
  return stringify_collection(os, x.begin(), x.end());
}

template <class T>
inline std::ostream &operator<<(std::ostream &os, ArrayRef<T> x) {
  return stringify_collection(os, x.begin(), x.end());
}

} // namespace llvm
