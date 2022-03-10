// pmlc-opt --convert-linalg-to-pxa  --convert-pxa-to-affine -x86-stage3 -x86-stage4 %s

#map4 = affine_map<__INPUT_MAP__>
#map5 = affine_map<__FILTER_MAP__>
#map6 = affine_map<__OUTPUT_MAP__>

func private @print_memref_f32(tensor<__OUTPUT_SHAPE__>)
func @prospar() {
  %cst = constant 2.000000e+00 : f32

  %6 = linalg.init_tensor __INPUT_DIM__ : tensor<__INPUT_SHAPE__>
  %7 = linalg.fill(%cst, %6) : f32, tensor<__INPUT_SHAPE__> -> tensor<__INPUT_SHAPE__>

  %8 = linalg.init_tensor __FILTER_DIM__ : tensor<__FILTER_SHAPE__>
  %9 = linalg.fill(%cst, %8) : f32, tensor<__FILTER_SHAPE__> -> tensor<__FILTER_SHAPE__>

  %10 = linalg.init_tensor __OUTPUT_DIM__ : tensor<__OUTPUT_SHAPE__>
  %11 = linalg.fill(%cst, %10) : f32, tensor<__OUTPUT_SHAPE__> -> tensor<__OUTPUT_SHAPE__>

  //convolution
  %12 = linalg.generic {indexing_maps = [#map4, #map5, #map6], iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction", "reduction", "parallel", "reduction"]} ins(%7, %9 : tensor<__INPUT_SHAPE__>, tensor<__FILTER_SHAPE__>) outs(%11 : tensor<__OUTPUT_SHAPE__>) {
  ^bb0(%arg0: f32, %arg1: f32, %arg2: f32):  // no predecessors
    %15 = mulf %arg0, %arg1 : f32
    %16 = addf %arg2, %15 : f32
    linalg.yield %16 : f32
  } -> tensor<__OUTPUT_SHAPE__>

  call @print_memref_f32(%12) : (tensor<__OUTPUT_SHAPE__>) -> ()
  return
}
