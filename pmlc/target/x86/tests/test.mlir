// pmlc-opt --x86-reorder-layouts -cse  --convert-linalg-to-pxa --x86-profile-kernels --convert-pxa-to-affine -x86-stage3 -x86-stage4 %s

func private @print_memref_f32(tensor<1x56x56x64xf32>)

#input  = affine_map<(n, h, w, c, r, s, k) -> (n, h + r, w + s, k)>
#filter = affine_map<(n, h, w, c, r, s, k) -> (r, s, k, c)>
#output = affine_map<(n, h, w, c, r, s, k) -> (n, h, w, c)>

func @prospar() {
  %c0 = constant 2.0 : f32
  %T0 = linalg.init_tensor [1, 56, 56, 64] : tensor<1x56x56x64xf32>
  %0 = linalg.fill(%c0, %T0):f32, tensor<1x56x56x64xf32> -> tensor<1x56x56x64xf32>
  %T1 = linalg.init_tensor [1, 1, 64, 64] : tensor<1x1x64x64xf32>
  %1 = linalg.fill(%c0, %T1):f32, tensor<1x1x64x64xf32> -> tensor<1x1x64x64xf32>
  %T2 = linalg.init_tensor [1, 56, 56, 64] : tensor<1x56x56x64xf32>
  %2 = linalg.fill(%c0, %T2):f32, tensor<1x56x56x64xf32> -> tensor<1x56x56x64xf32>

  // convolution
  %3 = linalg.generic {
    indexing_maps = [#input, #filter, #output],
    iterator_types = ["parallel", "parallel", "parallel", "parallel", "reduction", "reduction", "reduction"]
  } ins(%0, %1 : tensor<1x56x56x64xf32>, tensor<1x1x64x64xf32>) outs(%2 : tensor<1x56x56x64xf32>) {
  ^bb0(%arg3: f32, %arg4: f32, %arg5: f32):  // no predecessors
    %5 = mulf %arg3, %arg4 : f32
    %6 = addf %arg5, %5 : f32
    linalg.yield %6 : f32
  } -> (tensor<1x56x56x64xf32>)

  call @print_memref_f32(%3):(tensor<1x56x56x64xf32>)-> ()
  return
}
