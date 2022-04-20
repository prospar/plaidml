module  {
  func private @print_memref_f32(memref<1x56x56x64xf32>)
  memref.global "private" constant @cst_scalar_memref_0 : memref<f32> = dense<2.000000e+00>
  func @prospar() {
    %0 = memref.get_global @cst_scalar_memref_0 : memref<f32>
    %1 = pxa.load %0[] : memref<f32>
    %2 = memref.alloc() : memref<1x56x56x64xf32>
    %3 = memref.alloc() : memref<1x56x56x64xf32>
    %4 = affine.parallel (%arg0, %arg1, %arg2, %arg3) = (0, 0, 0, 0) to (1, 56, 56, 64) reduce ("assign") -> (memref<1x56x56x64xf32>) {
      %23 = pxa.reduce assign %1, %3[%arg0, %arg1, %arg2, %arg3] : memref<1x56x56x64xf32>
      affine.yield %23 : memref<1x56x56x64xf32>
    }
    %5 = memref.alloc() : memref<1x1x64x64xf32>
    %6 = memref.alloc() : memref<1x1x64x64xf32>
    %7 = affine.parallel (%arg0, %arg1, %arg2, %arg3) = (0, 0, 0, 0) to (1, 1, 64, 64) reduce ("assign") -> (memref<1x1x64x64xf32>) {
      %23 = pxa.reduce assign %1, %6[%arg0, %arg1, %arg2, %arg3] : memref<1x1x64x64xf32>
      affine.yield %23 : memref<1x1x64x64xf32>
    }
    %8 = memref.alloc() : memref<1x56x56x64xf32>
    %9 = affine.parallel (%arg0, %arg1, %arg2, %arg3) = (0, 0, 0, 0) to (1, 56, 56, 64) reduce ("assign") -> (memref<1x56x56x64xf32>) {
      %23 = pxa.reduce assign %1, %8[%arg0, %arg1, %arg2, %arg3] : memref<1x56x56x64xf32>
      affine.yield %23 : memref<1x56x56x64xf32>
    }
    %10 = memref.alloc() : memref<1x2x56x56x32xf32>
    %11 = memref.alloc() : memref<1x2x56x56x32xf32>
    %12 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4) = (0, 0, 0, 0, 0) to (1, 2, 56, 56, 32) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
      %23 = pxa.load %4[%arg0, %arg2, %arg3, %arg1 * 32 + %arg4] : memref<1x56x56x64xf32>
      %24 = pxa.reduce assign %23, %11[%arg0, %arg1, %arg2, %arg3, %arg4] : memref<1x2x56x56x32xf32>
      affine.yield %24 : memref<1x2x56x56x32xf32>
    }
    %13 = memref.alloc() : memref<2x2x1x1x32x32xf32>
    %14 = memref.alloc() : memref<2x2x1x1x32x32xf32>
    %15 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4, %arg5) = (0, 0, 0, 0, 0, 0) to (2, 2, 1, 1, 32, 32) reduce ("assign") -> (memref<2x2x1x1x32x32xf32>) {
      %23 = pxa.load %7[%arg2, %arg3, %arg0 * 32 + %arg4, %arg1 * 32 + %arg5] : memref<1x1x64x64xf32>
      %24 = pxa.reduce assign %23, %14[%arg0, %arg1, %arg2, %arg3, %arg4, %arg5] : memref<2x2x1x1x32x32xf32>
      affine.yield %24 : memref<2x2x1x1x32x32xf32>
    }
    %16 = memref.alloc() : memref<1x2x56x56x32xf32>
    %17 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4) = (0, 0, 0, 0, 0) to (1, 2, 56, 56, 32) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
      %23 = pxa.load %9[%arg0, %arg2, %arg3, %arg1 * 32 + %arg4] : memref<1x56x56x64xf32>
      %24 = pxa.reduce assign %23, %16[%arg0, %arg1, %arg2, %arg3, %arg4] : memref<1x2x56x56x32xf32>
      affine.yield %24 : memref<1x2x56x56x32xf32>
    }
    %18 = memref.alloc() : memref<1x2x56x56x32xf32>
    %19 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4) = (0, 0, 0, 0, 0) to (1, 2, 56, 56, 32) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
      %23 = pxa.load %17[%arg0, %arg1, %arg2, %arg3, %arg4] : memref<1x2x56x56x32xf32>
      %24 = pxa.reduce assign %23, %18[%arg0, %arg1, %arg2, %arg3, %arg4] : memref<1x2x56x56x32xf32>
      affine.yield %24 : memref<1x2x56x56x32xf32>
    }
    %20 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8) = (0, 0, 0, 0, 0, 0, 0, 0, 0) to (1, 56, 56, 32, 1, 1, 32, 2, 2) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
      %23 = pxa.load %12[%arg0, %arg8, %arg1 + %arg4, %arg2 + %arg5, %arg6] : memref<1x2x56x56x32xf32>
      %24 = pxa.load %15[%arg8, %arg7, %arg4, %arg5, %arg6, %arg3] : memref<2x2x1x1x32x32xf32>
      %25 = mulf %23, %24 : f32
      %26 = pxa.reduce addf %25, %19[%arg0, %arg7, %arg1, %arg2, %arg3] : memref<1x2x56x56x32xf32>
      affine.yield %26 : memref<1x2x56x56x32xf32>
    }
    %21 = memref.alloc() : memref<1x56x56x64xf32>
    %22 = affine.parallel (%arg0, %arg1, %arg2, %arg3, %arg4) = (0, 0, 0, 0, 0) to (1, 2, 56, 56, 32) reduce ("assign") -> (memref<1x56x56x64xf32>) {
      %23 = pxa.load %20[%arg0, %arg1, %arg2, %arg3, %arg4] : memref<1x2x56x56x32xf32>
      %24 = pxa.reduce assign %23, %21[%arg0, %arg2, %arg3, %arg1 * 32 + %arg4] : memref<1x56x56x64xf32>
      affine.yield %24 : memref<1x56x56x64xf32>
    }
    call @print_memref_f32(%22) : (memref<1x56x56x64xf32>) -> ()
    return
  }
}

