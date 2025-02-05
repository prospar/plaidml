// RUN: pmlc-opt -convert-stdx-to-llvm %s | FileCheck %s
// RUN: pmlc-opt -x86-convert-std-to-llvm %s | pmlc-jit -e jitEntry | FileCheck %s --check-prefix=JIT

// CHECK-LABEL: @packLowering
func @packLowering(%A: memref<20x10xf32>, %i: index, %f: f32) -> tuple<memref<20x10xf32>, index, f32> {
  %0 = stdx.pack(%A, %i, %f) : (memref<20x10xf32>, index, f32) -> tuple<memref<20x10xf32>, index, f32>
  // llvm.call @malloc
  // llvm.bitcast
  // llvm.mlir.undef
  // llvm.insertvalue
  // llvm.insertvalue
  // llvm.insertvalue
  // llvm.store
  return %0 : tuple<memref<20x10xf32>, index, f32>
}

// CHECK-LABEL: @unpackLowering
func @unpackLowering(%P: tuple<memref<20x10xf32>, index, f32>) -> (memref<20x10xf32>, index, f32) {
  %A, %i, %f = stdx.unpack(%P) : (tuple<memref<20x10xf32>, index, f32>) -> (memref<20x10xf32>, index, f32)
  // llvm.bitcast
  // llvm.load
  // llvm.extractvalue
  // llvm.extractvalue
  // llvm.extractvalue
  return %A, %i, %f : memref<20x10xf32>, index, f32
}

func private @print_memref_f32(memref<*xf32>)

func @jitEntry() -> () {
  %in = memref.alloc() : memref<3xf32>
  %a = constant 1.0 : f32
  %b = constant 2.0 : f32
  %c = constant 3.0 : f32
  %p = stdx.pack(%in, %a, %b, %c) : (memref<3xf32>, f32, f32, f32) -> tuple<memref<3xf32>, f32, f32, f32>
  %out, %a2, %b2, %c2 = stdx.unpack(%p) : (tuple<memref<3xf32>, f32, f32, f32>) -> (memref<3xf32>, f32, f32, f32)
  %i0 = constant 0 : index
  %i1 = constant 1 : index
  %i2 = constant 2 : index
  memref.store %a2, %out[%i0] : memref<3xf32>
  memref.store %b2, %out[%i1] : memref<3xf32>
  memref.store %c2, %out[%i2] : memref<3xf32>
  %outUnranked = memref.cast %out : memref<3xf32> to memref<*xf32>
  call @print_memref_f32(%outUnranked) : (memref<*xf32>) -> ()
  // JIT: [1, 2, 3]
  memref.dealloc %in : memref<3xf32>
  return
}
