// pmlc-opt --x86-reorder-layouts -cse  --convert-linalg-to-pxa  --convert-pxa-to-affine -x86-stage3 -x86-stage4 %s

func private @print_memref_f32(tensor<__OUTPUT_SHAPE__>)

#input  = affine_map<__INPUT_MAP__>
#filter = affine_map<__FILTER_MAP__>
#output = affine_map<__OUTPUT_MAP__>

func @prospar() {
  %c0 = constant 2.0 : f32
  %T0 = linalg.init_tensor __INPUT_DIM__ : tensor<__INPUT_SHAPE__>
  %0 = linalg.fill(%c0, %T0):f32, tensor<__INPUT_SHAPE__> -> tensor<__INPUT_SHAPE__>
  %T1 = linalg.init_tensor __FILTER_DIM__ : tensor<__FILTER_SHAPE__>
  %1 = linalg.fill(%c0, %T1):f32, tensor<__FILTER_SHAPE__> -> tensor<__FILTER_SHAPE__>
  %T2 = linalg.init_tensor __OUTPUT_DIM__ : tensor<__OUTPUT_SHAPE__>
  %2 = linalg.fill(%c0, %T2):f32, tensor<__OUTPUT_SHAPE__> -> tensor<__OUTPUT_SHAPE__>

  // convolution
  %3 = linalg.generic {
    indexing_maps = [#input, #filter, #output],
    iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction", "reduction"]
  } ins(%0, %1 : tensor<__INPUT_SHAPE__>, tensor<__FILTER_SHAPE__>) outs(%2 : tensor<__OUTPUT_SHAPE__>) {
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):  // no predecessors
    %5 = mulf %arg3, %arg4 : f32
    %6 = addf %arg5, %5 : f32
    linalg.yield %6 : f32
  } -> (tensor<__OUTPUT_SHAPE__>)

  call @print_memref_f32(%3):(tensor<__OUTPUT_SHAPE__>)-> ()
  return
}
