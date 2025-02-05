// RUN: pmlc-opt -convert-tile-to-linalg %s | FileCheck %s

func @reshaper0(%arg0: tensor<1x1x60xf32>) -> tensor<60xf32> {
  %0 = tile.reshape %arg0 : (tensor<1x1x60xf32>) -> tensor<60xf32>
  return %0 : tensor<60xf32>
}

// CHECK-LABEL: func @reshaper0
// CHECK: linalg.tensor_collapse_shape
// CHECK: tensor<60xf32>

func @reshaper1(%arg0: tensor<2x4x5xf32>) -> tensor<2x20xf32> {
  %0 = tile.reshape %arg0 : (tensor<2x4x5xf32>) -> tensor<2x20xf32>
  return %0 : tensor<2x20xf32>
}

// CHECK-LABEL: func @reshaper1
// CHECK: linalg.tensor_collapse_shape
// CHECK: tensor<2x20xf32>

func @reshaper2(%arg1: tensor<5x2x3xf32>) -> tensor<5x6xf32> {
  %0 = tile.reshape %arg1 : (tensor<5x2x3xf32>) -> tensor<5x6xf32>
  return %0 : tensor<5x6xf32>
}

// CHECK-LABEL: func @reshaper2
// CHECK: linalg.tensor_collapse_shape
// CHECK: tensor<5x6xf32>

func @reshaper3(%arg1: tensor<5x6xf32>) -> tensor<5x2x3xf32> {
  %0 = tile.reshape %arg1 : (tensor<5x6xf32>) -> tensor<5x2x3xf32>
  return %0 : tensor<5x2x3xf32>
}

// CHECK-LABEL: func @reshaper3
// CHECK: linalg.tensor_expand_shape
// CHECK: tensor<5x6xf32>

func @squeeze(%arg0: tensor<4x2x1x3x2xf32>) -> tensor<4x2x3x2xf32> {
  %0 = tile.reshape %arg0 : (tensor<4x2x1x3x2xf32>) -> tensor<4x2x3x2xf32>
  return %0 : tensor<4x2x3x2xf32>
}

// CHECK-LABEL: func @squeeze
// CHECK: linalg.tensor_collapse_shape
// CHECK: tensor<4x2x3x2xf32>

func @zero_dim(%arg0: tensor<si32>) -> tensor<1x1x1xsi32> {
  %0 = tile.reshape %arg0 : (tensor<si32>) -> tensor<1x1x1xsi32>
  return %0 : tensor<1x1x1xsi32>
}

// CHECK: func @zero_dim
// CHECK-SAME: (%[[arg0:.*]]: tensor<i32>) -> tensor<1x1x1xi32>
// CHECK:   linalg.tensor_expand_shape %[[arg0]] [] : tensor<i32> into tensor<1x1x1xi32>

func @general_reshape(%arg0: tensor<4x3x70x2xf32>) -> tensor<14x10x6x2xf32> {
  %0 = tile.reshape %arg0 : (tensor<4x3x70x2xf32>) -> tensor<14x10x6x2xf32>
  return %0 : tensor<14x10x6x2xf32>
}

// CHECK-LABEL: func @general_reshape
// CHECK-SAME: (%[[arg0:.*]]: tensor<4x3x70x2xf32>) -> tensor<14x10x6x2xf32>
// CHECK:   %[[tmp:.*]] = linalg.tensor_collapse_shape %[[arg0]]
// CHECK-SAME{LITERAL}: [[0, 1, 2, 3]] : tensor<4x3x70x2xf32> into tensor<1680xf32>
// CHECK:   linalg.tensor_expand_shape %[[tmp]]
// CHECK-SAME{LITERAL}: [[0, 1, 2, 3]] : tensor<1680xf32> into tensor<14x10x6x2xf32>
