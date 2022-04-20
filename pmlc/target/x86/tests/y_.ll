#map0 = affine_map<(d0, d1) -> (0, 0, d0, d1)>
#map1 = affine_map<(d0, d1) -> ()>
#map2 = affine_map<(d0, d1) -> (0, 0, 0, d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, 0, 0, 0, d0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (0, 0, 0, d0, d1)>
#map5 = affine_map<(d0, d1, d2, d3) -> (0, d3, 0, d0, d2)>
#map6 = affine_map<(d0, d1, d2, d3) -> (d3, 0, 0, 0, d2, d1)>
module  {
  func private @plaidml_rt_instrument(i64, i64)
  func private @print_memref_f32(memref<1x56x56x64xf32>)
  memref.global "private" constant @cst_scalar_memref_0 : memref<f32> = dense<2.000000e+00>
  func @prospar() {
    %c1_i64 = constant 1 : i64
    %c0_i64 = constant 0 : i64
    %c3_i64 = constant 3 : i64
    %c2_i64 = constant 2 : i64
    %0 = memref.get_global @cst_scalar_memref_0 : memref<f32>
    %1 = pxa.load %0[] : memref<f32>
    %2 = memref.alloc() : memref<1x1x64x64xf32>
    call @plaidml_rt_instrument(%c0_i64, %c0_i64) : (i64, i64) -> ()
    %3 = affine.parallel (%arg0, %arg1) = (0, 0) to (2, 4) reduce ("assign") -> (memref<1x1x64x64xf32>) {
      %10 = pxa.generic (%2[0, 0, %arg0 * 32, %arg1 * 16]: #map0) <assign> @tpp_identity(%0[]: #map1) tile: [32, 16] : (memref<f32>) -> memref<1x1x64x64xf32>
      affine.yield %10 : memref<1x1x64x64xf32>
    } {tags = {cpuThread}}
    call @plaidml_rt_instrument(%c0_i64, %c1_i64) : (i64, i64) -> ()
    %4 = memref.alloc() : memref<1x2x56x56x32xf32>
    call @plaidml_rt_instrument(%c1_i64, %c0_i64) : (i64, i64) -> ()
    %5 = affine.parallel (%arg0, %arg1) = (0, 0) to (4, 2) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
      %10 = affine.parallel (%arg2) = (0) to (56) reduce ("assign") -> (memref<1x2x56x56x32xf32>) {
        %11 = pxa.generic (%4[0, %arg1, %arg2, %arg0 * 14, 0]: #map2) <assign> @tpp_identity(%0[]: #map1) tile: [14, 32] : (memref<f32>) -> memref<1x2x56x56x32xf32>
        affine.yield %11 : memref<1x2x56x56x32xf32>
      }
      affine.yield %10 : memref<1x2x56x56x32xf32>
    } {tags = {cpuThread}}
    call @plaidml_rt_instrument(%c1_i64, %c1_i64) : (i64, i64) -> ()
    %6 = memref.alloc() : memref<2x2x1x1x32x32xf32>
    call @plaidml_rt_instrument(%c2_i64, %c0_i64) : (i64, i64) -> ()
    %7 = affine.parallel (%arg0, %arg1) = (0, 0) to (2, 4) reduce ("assign") -> (memref<2x2x1x1x32x32xf32>) {
      %10 = affine.parallel (%arg2) = (0) to (2) reduce ("assign") -> (memref<2x2x1x1x32x32xf32>) {
        %11 = pxa.generic (%6[%arg0, %arg2, 0, 0, 0, %arg1 * 8]: #map3) <assign> @tpp_identity(%3[0, 0, %arg0 * 32, %arg2 * 32 + %arg1 * 8]: #map0) tile: [32, 8] : (memref<1x1x64x64xf32>) -> memref<2x2x1x1x32x32xf32>
        affine.yield %11 : memref<2x2x1x1x32x32xf32>
      }
      affine.yield %10 : memref<2x2x1x1x32x32xf32>
    } {tags = {cpuThread}}
    call @plaidml_rt_instrument(%c2_i64, %c1_i64) : (i64, i64) -> ()
    memref.dealloc %2 : memref<1x1x64x64xf32>
    %8 = memref.alloc() : memref<1x56x56x64xf32>
    call @plaidml_rt_instrument(%c3_i64, %c0_i64) : (i64, i64) -> ()
    %9 = affine.parallel (%arg0, %arg1) = (0, 0) to (4, 2) reduce ("assign") -> (memref<1x56x56x64xf32>) {
      %10 = affine.parallel (%arg2) = (0) to (14) reduce ("assign") -> (memref<1x56x56x64xf32>) {
        %11 = memref.alloc() : memref<1x1x1x56x32xf32>
        %12 = affine.parallel (%arg3) = (0) to (56) reduce ("assign") -> (memref<1x1x1x56x32xf32>) {
          %15 = memref.alloc() : memref<1x1x1x32xf32>
          %16 = memref.alloc() : memref<1x1x1x1x32xf32>
          %17 = affine.parallel (%arg4) = (0) to (32) reduce ("assign") -> (memref<1x1x1x32xf32>) {
            %20 = pxa.reduce assign %1, %15[0, 0, 0, %arg4] : memref<1x1x1x32xf32>
            affine.yield %20 : memref<1x1x1x32xf32>
          }
          %18 = affine.parallel (%arg4) = (0) to (32) reduce ("assign") -> (memref<1x1x1x1x32xf32>) {
            %20 = pxa.load %17[0, 0, 0, %arg4] : memref<1x1x1x32xf32>
            %21 = pxa.reduce assign %20, %16[0, 0, 0, 0, %arg4] : memref<1x1x1x1x32xf32>
            affine.yield %21 : memref<1x1x1x1x32xf32>
          }
          memref.dealloc %15 : memref<1x1x1x32xf32>
          %19 = affine.parallel (%arg4) = (0) to (32) reduce ("assign") -> (memref<1x1x1x56x32xf32>) {
            %20 = pxa.load %18[0, 0, 0, 0, %arg4] : memref<1x1x1x1x32xf32>
            %21 = pxa.reduce assign %20, %11[0, 0, 0, %arg3, %arg4] : memref<1x1x1x56x32xf32>
            affine.yield %21 : memref<1x1x1x56x32xf32>
          }
          memref.dealloc %16 : memref<1x1x1x1x32xf32>
          affine.yield %19 : memref<1x1x1x56x32xf32>
        }
        %13 = pxa.generic (%12[0, 0, 0, 0, 0]: #map4) <addf> @tpp_gemm(%5[0, 0, %arg2 + %arg0 * 14, 0, 0]: #map5, %7[0, %arg1, 0, 0, 0, 0]: #map6) tile: [56, 32, 32, 1, 2] : (memref<1x2x56x56x32xf32>, memref<2x2x1x1x32x32xf32>) -> memref<1x1x1x56x32xf32>
        %14 = pxa.generic (%8[0, %arg2 + %arg0 * 14, 0, %arg1 * 32]: #map0) <assign> @tpp_identity(%13[0, 0, 0, 0, 0]: #map2) tile: [56, 32] : (memref<1x1x1x56x32xf32>) -> memref<1x56x56x64xf32>
        memref.dealloc %11 : memref<1x1x1x56x32xf32>
        affine.yield %14 : memref<1x56x56x64xf32>
      }
      affine.yield %10 : memref<1x56x56x64xf32>
    } {tags = {cpuThread}}
    call @plaidml_rt_instrument(%c3_i64, %c1_i64) : (i64, i64) -> ()
    memref.dealloc %6 : memref<2x2x1x1x32x32xf32>
    memref.dealloc %4 : memref<1x2x56x56x32xf32>
    call @print_memref_f32(%9) : (memref<1x56x56x64xf32>) -> ()
    memref.dealloc %8 : memref<1x56x56x64xf32>
    return
  }
}

