module  {
  llvm.mlir.global internal constant @__loc_str_7("FileLineColLoc|FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_6("FileLineColLoc|FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_5("FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_4("FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_3("FileLineColLoc|FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_2("FileLineColLoc|FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_1("FileLineColLoc\00")
  llvm.mlir.global internal constant @__loc_str_0("FileLineColLoc\00")
  llvm.func @plaidml_rt_xsmm_brgemm_offs_invoke_f32(i64, !llvm.ptr<f32>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, !llvm.ptr<i64>, !llvm.ptr<i64>)
  llvm.mlir.global internal constant @brgemm_aoffsets0(dense<[0, 401408]> : tensor<2xi64>) : !llvm.array<2 x i64>
  llvm.mlir.global internal constant @brgemm_boffsets0(dense<[0, 8192]> : tensor<2xi64>) : !llvm.array<2 x i64>
  llvm.func @plaidml_rt_xsmm_brgemm_offs_dispatch_f32(i32, i32, i32, i32, i32, i32) -> i64
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @plaidml_rt_xsmm_unary_invoke(i64, !llvm.ptr<i8>, !llvm.ptr<i8>)
  llvm.func @plaidml_rt_xsmm_unary_dispatch(i32, i32, i32, i32, i32, i32, i32, i32, i32) -> i64
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @plaidml_rt_instrument(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr<i8>) {
    llvm.call @_mlir_ciface_plaidml_rt_instrument(%arg0, %arg1, %arg2) : (i64, i64, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_plaidml_rt_instrument(i64, i64, !llvm.ptr<i8>)
  llvm.func @print_memref_f32(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: i64, %arg9: i64, %arg10: i64) attributes {sym_visibility = "private"} {
    %0 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %1 = llvm.insertvalue %arg0, %0[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %2 = llvm.insertvalue %arg1, %1[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %3 = llvm.insertvalue %arg2, %2[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %4 = llvm.insertvalue %arg3, %3[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %5 = llvm.insertvalue %arg7, %4[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %6 = llvm.insertvalue %arg4, %5[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %7 = llvm.insertvalue %arg8, %6[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %8 = llvm.insertvalue %arg5, %7[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %9 = llvm.insertvalue %arg9, %8[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %10 = llvm.insertvalue %arg6, %9[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %11 = llvm.insertvalue %arg10, %10[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.alloca %12 x !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)> : (i64) -> !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>>
    llvm.store %11, %13 : !llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>>
    llvm.call @_mlir_ciface_print_memref_f32(%13) : (!llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_print_memref_f32(!llvm.ptr<struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>>) attributes {sym_visibility = "private"}
  llvm.mlir.global private constant @cst_scalar_memref_0(2.000000e+00 : f32) : f32
  llvm.func @prospar() {
    %0 = llvm.mlir.constant(32 : index) : i64
    %1 = llvm.mlir.constant(56 : index) : i64
    %2 = llvm.mlir.constant(14 : index) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(16 : index) : i64
    %8 = llvm.mlir.constant(2 : index) : i64
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.mlir.constant(1 : index) : i64
    %11 = llvm.mlir.constant(4 : index) : i64
    %12 = llvm.mlir.constant(8 : index) : i64
    %13 = llvm.mlir.constant(1 : index) : i64
    %14 = llvm.mlir.null : !llvm.ptr<f32>
    %15 = llvm.getelementptr %14[%13] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %16 = llvm.ptrtoint %15 : !llvm.ptr<f32> to i64
    %17 = llvm.mlir.addressof @cst_scalar_memref_0 : !llvm.ptr<f32>
    %18 = llvm.mlir.constant(0 : index) : i64
    %19 = llvm.getelementptr %17[%18] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %20 = llvm.mlir.constant(3735928559 : index) : i64
    %21 = llvm.inttoptr %20 : i64 to !llvm.ptr<f32>
    %22 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
    %23 = llvm.insertvalue %21, %22[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
    %24 = llvm.insertvalue %19, %23[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
    %25 = llvm.mlir.constant(0 : index) : i64
    %26 = llvm.insertvalue %25, %24[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
    %27 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
    %28 = llvm.load %27 : !llvm.ptr<f32>
    %29 = llvm.mlir.constant(1 : index) : i64
    %30 = llvm.mlir.constant(1 : index) : i64
    %31 = llvm.mlir.constant(64 : index) : i64
    %32 = llvm.mlir.constant(64 : index) : i64
    %33 = llvm.mlir.constant(1 : index) : i64
    %34 = llvm.mlir.constant(4096 : index) : i64
    %35 = llvm.mlir.constant(4096 : index) : i64
    %36 = llvm.mlir.constant(4096 : index) : i64
    %37 = llvm.mlir.null : !llvm.ptr<f32>
    %38 = llvm.getelementptr %37[%36] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %39 = llvm.ptrtoint %38 : !llvm.ptr<f32> to i64
    %40 = llvm.call @malloc(%39) : (i64) -> !llvm.ptr<i8>
    %41 = llvm.bitcast %40 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %42 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %43 = llvm.insertvalue %41, %42[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %44 = llvm.insertvalue %41, %43[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %45 = llvm.mlir.constant(0 : index) : i64
    %46 = llvm.insertvalue %45, %44[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %47 = llvm.insertvalue %29, %46[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %48 = llvm.insertvalue %30, %47[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %49 = llvm.insertvalue %31, %48[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %50 = llvm.insertvalue %32, %49[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %51 = llvm.insertvalue %35, %50[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %52 = llvm.insertvalue %34, %51[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %53 = llvm.insertvalue %32, %52[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %54 = llvm.insertvalue %33, %53[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %55 = llvm.mlir.addressof @__loc_str_0 : !llvm.ptr<array<15 x i8>>
    %56 = llvm.mlir.constant(0 : index) : i64
    %57 = llvm.getelementptr %55[%56, %56] : (!llvm.ptr<array<15 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%4, %4, %57) : (i64, i64, !llvm.ptr<i8>) -> ()
    %58 = llvm.mlir.constant(32 : i64) : i32
    %59 = llvm.mlir.constant(16 : i64) : i32
    %60 = llvm.mlir.constant(64 : i64) : i32
    %61 = llvm.mlir.constant(64 : i64) : i32
    %62 = llvm.mlir.constant(1 : i32) : i32
    %63 = llvm.mlir.constant(1 : i32) : i32
    %64 = llvm.mlir.constant(1 : i32) : i32
    %65 = llvm.mlir.constant(1 : i32) : i32
    %66 = llvm.mlir.constant(3 : i32) : i32
    %67 = llvm.call @plaidml_rt_xsmm_unary_dispatch(%58, %59, %60, %61, %62, %63, %64, %65, %66) : (i32, i32, i32, i32, i32, i32, i32, i32, i32) -> i64
    %68 = llvm.intr.stacksave : !llvm.ptr<i8>
    omp.parallel {
      omp.wsloop (%arg0) : i64 = (%9) to (%12) step (%10) {
        %239 = llvm.srem %arg0, %11  : i64
        %240 = llvm.sdiv %arg0, %11  : i64
        %241 = llvm.mul %240, %0  : i64
        %242 = llvm.mul %239, %7  : i64
        %243 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
        %244 = llvm.bitcast %243 : !llvm.ptr<f32> to !llvm.ptr<i8>
        %245 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %246 = llvm.mlir.constant(4096 : index) : i64
        %247 = llvm.mul %9, %246  : i64
        %248 = llvm.mlir.constant(4096 : index) : i64
        %249 = llvm.mul %9, %248  : i64
        %250 = llvm.add %247, %249  : i64
        %251 = llvm.mlir.constant(64 : index) : i64
        %252 = llvm.mul %241, %251  : i64
        %253 = llvm.add %250, %252  : i64
        %254 = llvm.add %253, %242  : i64
        %255 = llvm.getelementptr %245[%254] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %256 = llvm.bitcast %255 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @plaidml_rt_xsmm_unary_invoke(%67, %244, %256) : (i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
        omp.yield
      }
      omp.terminator
    }
    llvm.intr.stackrestore %68
    %69 = llvm.mlir.addressof @__loc_str_1 : !llvm.ptr<array<15 x i8>>
    %70 = llvm.mlir.constant(0 : index) : i64
    %71 = llvm.getelementptr %69[%70, %70] : (!llvm.ptr<array<15 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%4, %3, %71) : (i64, i64, !llvm.ptr<i8>) -> ()
    %72 = llvm.mlir.constant(1 : index) : i64
    %73 = llvm.mlir.constant(2 : index) : i64
    %74 = llvm.mlir.constant(56 : index) : i64
    %75 = llvm.mlir.constant(56 : index) : i64
    %76 = llvm.mlir.constant(32 : index) : i64
    %77 = llvm.mlir.constant(1 : index) : i64
    %78 = llvm.mlir.constant(1792 : index) : i64
    %79 = llvm.mlir.constant(100352 : index) : i64
    %80 = llvm.mlir.constant(200704 : index) : i64
    %81 = llvm.mlir.constant(200704 : index) : i64
    %82 = llvm.mlir.null : !llvm.ptr<f32>
    %83 = llvm.getelementptr %82[%81] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %84 = llvm.ptrtoint %83 : !llvm.ptr<f32> to i64
    %85 = llvm.call @malloc(%84) : (i64) -> !llvm.ptr<i8>
    %86 = llvm.bitcast %85 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %87 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %88 = llvm.insertvalue %86, %87[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %89 = llvm.insertvalue %86, %88[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %90 = llvm.mlir.constant(0 : index) : i64
    %91 = llvm.insertvalue %90, %89[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %92 = llvm.insertvalue %72, %91[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %93 = llvm.insertvalue %73, %92[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %94 = llvm.insertvalue %74, %93[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %95 = llvm.insertvalue %75, %94[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %96 = llvm.insertvalue %76, %95[3, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %97 = llvm.insertvalue %80, %96[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %98 = llvm.insertvalue %79, %97[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %99 = llvm.insertvalue %78, %98[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %100 = llvm.insertvalue %76, %99[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %101 = llvm.insertvalue %77, %100[4, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %102 = llvm.mlir.addressof @__loc_str_2 : !llvm.ptr<array<30 x i8>>
    %103 = llvm.mlir.constant(0 : index) : i64
    %104 = llvm.getelementptr %102[%103, %103] : (!llvm.ptr<array<30 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%3, %4, %104) : (i64, i64, !llvm.ptr<i8>) -> ()
    %105 = llvm.mlir.constant(14 : i64) : i32
    %106 = llvm.mlir.constant(32 : i64) : i32
    %107 = llvm.mlir.constant(32 : i64) : i32
    %108 = llvm.mlir.constant(32 : i64) : i32
    %109 = llvm.mlir.constant(1 : i32) : i32
    %110 = llvm.mlir.constant(1 : i32) : i32
    %111 = llvm.mlir.constant(1 : i32) : i32
    %112 = llvm.mlir.constant(1 : i32) : i32
    %113 = llvm.mlir.constant(3 : i32) : i32
    %114 = llvm.call @plaidml_rt_xsmm_unary_dispatch(%105, %106, %107, %108, %109, %110, %111, %112, %113) : (i32, i32, i32, i32, i32, i32, i32, i32, i32) -> i64
    %115 = llvm.intr.stacksave : !llvm.ptr<i8>
    omp.parallel {
      omp.wsloop (%arg0) : i64 = (%9) to (%12) step (%10) {
        %239 = llvm.srem %arg0, %8  : i64
        %240 = llvm.sdiv %arg0, %8  : i64
        %241 = llvm.mul %240, %2  : i64
        llvm.br ^bb1(%9 : i64)
      ^bb1(%242: i64):  // 2 preds: ^bb0, ^bb2
        %243 = llvm.icmp "slt" %242, %1 : i64
        llvm.cond_br %243, ^bb2, ^bb3
      ^bb2:  // pred: ^bb1
        %244 = llvm.extractvalue %26[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64)>
        %245 = llvm.bitcast %244 : !llvm.ptr<f32> to !llvm.ptr<i8>
        %246 = llvm.extractvalue %101[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %247 = llvm.mlir.constant(200704 : index) : i64
        %248 = llvm.mul %9, %247  : i64
        %249 = llvm.mlir.constant(100352 : index) : i64
        %250 = llvm.mul %239, %249  : i64
        %251 = llvm.add %248, %250  : i64
        %252 = llvm.mlir.constant(1792 : index) : i64
        %253 = llvm.mul %242, %252  : i64
        %254 = llvm.add %251, %253  : i64
        %255 = llvm.mlir.constant(32 : index) : i64
        %256 = llvm.mul %241, %255  : i64
        %257 = llvm.add %254, %256  : i64
        %258 = llvm.add %257, %9  : i64
        %259 = llvm.getelementptr %246[%258] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %260 = llvm.bitcast %259 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @plaidml_rt_xsmm_unary_invoke(%114, %245, %260) : (i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
        %261 = llvm.add %242, %10  : i64
        llvm.br ^bb1(%261 : i64)
      ^bb3:  // pred: ^bb1
        omp.yield
      }
      omp.terminator
    }
    llvm.intr.stackrestore %115
    %116 = llvm.mlir.addressof @__loc_str_3 : !llvm.ptr<array<30 x i8>>
    %117 = llvm.mlir.constant(0 : index) : i64
    %118 = llvm.getelementptr %116[%117, %117] : (!llvm.ptr<array<30 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%3, %3, %118) : (i64, i64, !llvm.ptr<i8>) -> ()
    %119 = llvm.mlir.constant(2 : index) : i64
    %120 = llvm.mlir.constant(2 : index) : i64
    %121 = llvm.mlir.constant(1 : index) : i64
    %122 = llvm.mlir.constant(1 : index) : i64
    %123 = llvm.mlir.constant(32 : index) : i64
    %124 = llvm.mlir.constant(32 : index) : i64
    %125 = llvm.mlir.constant(1 : index) : i64
    %126 = llvm.mlir.constant(1024 : index) : i64
    %127 = llvm.mlir.constant(1024 : index) : i64
    %128 = llvm.mlir.constant(1024 : index) : i64
    %129 = llvm.mlir.constant(2048 : index) : i64
    %130 = llvm.mlir.constant(4096 : index) : i64
    %131 = llvm.mlir.null : !llvm.ptr<f32>
    %132 = llvm.getelementptr %131[%130] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %133 = llvm.ptrtoint %132 : !llvm.ptr<f32> to i64
    %134 = llvm.call @malloc(%133) : (i64) -> !llvm.ptr<i8>
    %135 = llvm.bitcast %134 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %136 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %137 = llvm.insertvalue %135, %136[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %138 = llvm.insertvalue %135, %137[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %139 = llvm.mlir.constant(0 : index) : i64
    %140 = llvm.insertvalue %139, %138[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %141 = llvm.insertvalue %119, %140[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %142 = llvm.insertvalue %120, %141[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %143 = llvm.insertvalue %121, %142[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %144 = llvm.insertvalue %122, %143[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %145 = llvm.insertvalue %123, %144[3, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %146 = llvm.insertvalue %124, %145[3, 5] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %147 = llvm.insertvalue %129, %146[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %148 = llvm.insertvalue %128, %147[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %149 = llvm.insertvalue %127, %148[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %150 = llvm.insertvalue %126, %149[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %151 = llvm.insertvalue %124, %150[4, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %152 = llvm.insertvalue %125, %151[4, 5] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %153 = llvm.mlir.addressof @__loc_str_4 : !llvm.ptr<array<15 x i8>>
    %154 = llvm.mlir.constant(0 : index) : i64
    %155 = llvm.getelementptr %153[%154, %154] : (!llvm.ptr<array<15 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%6, %4, %155) : (i64, i64, !llvm.ptr<i8>) -> ()
    %156 = llvm.mlir.constant(32 : i64) : i32
    %157 = llvm.mlir.constant(8 : i64) : i32
    %158 = llvm.mlir.constant(64 : i64) : i32
    %159 = llvm.mlir.constant(32 : i64) : i32
    %160 = llvm.mlir.constant(1 : i32) : i32
    %161 = llvm.mlir.constant(1 : i32) : i32
    %162 = llvm.mlir.constant(1 : i32) : i32
    %163 = llvm.mlir.constant(1 : i32) : i32
    %164 = llvm.mlir.constant(0 : i32) : i32
    %165 = llvm.call @plaidml_rt_xsmm_unary_dispatch(%156, %157, %158, %159, %160, %161, %162, %163, %164) : (i32, i32, i32, i32, i32, i32, i32, i32, i32) -> i64
    %166 = llvm.intr.stacksave : !llvm.ptr<i8>
    omp.parallel {
      omp.wsloop (%arg0) : i64 = (%9) to (%12) step (%10) {
        %239 = llvm.srem %arg0, %11  : i64
        %240 = llvm.sdiv %arg0, %11  : i64
        %241 = llvm.mul %239, %12  : i64
        %242 = llvm.mul %240, %0  : i64
        llvm.br ^bb1(%9 : i64)
      ^bb1(%243: i64):  // 2 preds: ^bb0, ^bb2
        %244 = llvm.icmp "slt" %243, %8 : i64
        llvm.cond_br %244, ^bb2, ^bb3
      ^bb2:  // pred: ^bb1
        %245 = llvm.mul %243, %0  : i64
        %246 = llvm.add %245, %241  : i64
        %247 = llvm.extractvalue %54[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %248 = llvm.mlir.constant(4096 : index) : i64
        %249 = llvm.mul %9, %248  : i64
        %250 = llvm.mlir.constant(4096 : index) : i64
        %251 = llvm.mul %9, %250  : i64
        %252 = llvm.add %249, %251  : i64
        %253 = llvm.mlir.constant(64 : index) : i64
        %254 = llvm.mul %242, %253  : i64
        %255 = llvm.add %252, %254  : i64
        %256 = llvm.add %255, %246  : i64
        %257 = llvm.getelementptr %247[%256] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %258 = llvm.bitcast %257 : !llvm.ptr<f32> to !llvm.ptr<i8>
        %259 = llvm.extractvalue %152[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
        %260 = llvm.mlir.constant(2048 : index) : i64
        %261 = llvm.mul %240, %260  : i64
        %262 = llvm.mlir.constant(1024 : index) : i64
        %263 = llvm.mul %243, %262  : i64
        %264 = llvm.add %261, %263  : i64
        %265 = llvm.mlir.constant(1024 : index) : i64
        %266 = llvm.mul %9, %265  : i64
        %267 = llvm.add %264, %266  : i64
        %268 = llvm.mlir.constant(1024 : index) : i64
        %269 = llvm.mul %9, %268  : i64
        %270 = llvm.add %267, %269  : i64
        %271 = llvm.mlir.constant(32 : index) : i64
        %272 = llvm.mul %9, %271  : i64
        %273 = llvm.add %270, %272  : i64
        %274 = llvm.add %273, %241  : i64
        %275 = llvm.getelementptr %259[%274] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %276 = llvm.bitcast %275 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @plaidml_rt_xsmm_unary_invoke(%165, %258, %276) : (i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
        %277 = llvm.add %243, %10  : i64
        llvm.br ^bb1(%277 : i64)
      ^bb3:  // pred: ^bb1
        omp.yield
      }
      omp.terminator
    }
    llvm.intr.stackrestore %166
    %167 = llvm.mlir.addressof @__loc_str_5 : !llvm.ptr<array<15 x i8>>
    %168 = llvm.mlir.constant(0 : index) : i64
    %169 = llvm.getelementptr %167[%168, %168] : (!llvm.ptr<array<15 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%6, %3, %169) : (i64, i64, !llvm.ptr<i8>) -> ()
    %170 = llvm.extractvalue %54[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %171 = llvm.bitcast %170 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%171) : (!llvm.ptr<i8>) -> ()
    %172 = llvm.mlir.constant(1 : index) : i64
    %173 = llvm.mlir.constant(56 : index) : i64
    %174 = llvm.mlir.constant(56 : index) : i64
    %175 = llvm.mlir.constant(64 : index) : i64
    %176 = llvm.mlir.constant(1 : index) : i64
    %177 = llvm.mlir.constant(3584 : index) : i64
    %178 = llvm.mlir.constant(200704 : index) : i64
    %179 = llvm.mlir.constant(200704 : index) : i64
    %180 = llvm.mlir.null : !llvm.ptr<f32>
    %181 = llvm.getelementptr %180[%179] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
    %182 = llvm.ptrtoint %181 : !llvm.ptr<f32> to i64
    %183 = llvm.call @malloc(%182) : (i64) -> !llvm.ptr<i8>
    %184 = llvm.bitcast %183 : !llvm.ptr<i8> to !llvm.ptr<f32>
    %185 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %186 = llvm.insertvalue %184, %185[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %187 = llvm.insertvalue %184, %186[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %188 = llvm.mlir.constant(0 : index) : i64
    %189 = llvm.insertvalue %188, %187[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %190 = llvm.insertvalue %172, %189[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %191 = llvm.insertvalue %173, %190[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %192 = llvm.insertvalue %174, %191[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %193 = llvm.insertvalue %175, %192[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %194 = llvm.insertvalue %178, %193[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %195 = llvm.insertvalue %177, %194[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %196 = llvm.insertvalue %175, %195[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %197 = llvm.insertvalue %176, %196[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %198 = llvm.mlir.addressof @__loc_str_6 : !llvm.ptr<array<30 x i8>>
    %199 = llvm.mlir.constant(0 : index) : i64
    %200 = llvm.getelementptr %198[%199, %199] : (!llvm.ptr<array<30 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%5, %4, %200) : (i64, i64, !llvm.ptr<i8>) -> ()
    %201 = llvm.mlir.constant(32 : i64) : i32
    %202 = llvm.mlir.constant(32 : i64) : i32
    %203 = llvm.mlir.constant(32 : i64) : i32
    %204 = llvm.mlir.constant(56 : i64) : i32
    %205 = llvm.mlir.constant(32 : i64) : i32
    %206 = llvm.mlir.constant(32 : i64) : i32
    %207 = llvm.call @plaidml_rt_xsmm_brgemm_offs_dispatch_f32(%201, %202, %203, %204, %205, %206) : (i32, i32, i32, i32, i32, i32) -> i64
    %208 = llvm.mlir.constant(56 : i64) : i32
    %209 = llvm.mlir.constant(32 : i64) : i32
    %210 = llvm.mlir.constant(32 : i64) : i32
    %211 = llvm.mlir.constant(64 : i64) : i32
    %212 = llvm.mlir.constant(1 : i32) : i32
    %213 = llvm.mlir.constant(1 : i32) : i32
    %214 = llvm.mlir.constant(1 : i32) : i32
    %215 = llvm.mlir.constant(1 : i32) : i32
    %216 = llvm.mlir.constant(0 : i32) : i32
    %217 = llvm.call @plaidml_rt_xsmm_unary_dispatch(%208, %209, %210, %211, %212, %213, %214, %215, %216) : (i32, i32, i32, i32, i32, i32, i32, i32, i32) -> i64
    %218 = llvm.intr.stacksave : !llvm.ptr<i8>
    omp.parallel {
      omp.wsloop (%arg0) : i64 = (%9) to (%12) step (%10) {
        %239 = llvm.srem %arg0, %8  : i64
        %240 = llvm.sdiv %arg0, %8  : i64
        %241 = llvm.mul %240, %2  : i64
        %242 = llvm.mul %239, %0  : i64
        llvm.br ^bb1(%9 : i64)
      ^bb1(%243: i64):  // 2 preds: ^bb0, ^bb14
        %244 = llvm.icmp "slt" %243, %2 : i64
        llvm.cond_br %244, ^bb2, ^bb15
      ^bb2:  // pred: ^bb1
        %245 = llvm.mlir.constant(1 : index) : i64
        %246 = llvm.mlir.constant(1 : index) : i64
        %247 = llvm.mlir.constant(1 : index) : i64
        %248 = llvm.mlir.constant(56 : index) : i64
        %249 = llvm.mlir.constant(32 : index) : i64
        %250 = llvm.mlir.constant(1 : index) : i64
        %251 = llvm.mlir.constant(1792 : index) : i64
        %252 = llvm.mlir.constant(1792 : index) : i64
        %253 = llvm.mlir.constant(1792 : index) : i64
        %254 = llvm.mlir.constant(1792 : index) : i64
        %255 = llvm.mlir.null : !llvm.ptr<f32>
        %256 = llvm.getelementptr %255[%254] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %257 = llvm.ptrtoint %256 : !llvm.ptr<f32> to i64
        %258 = llvm.call @malloc(%257) : (i64) -> !llvm.ptr<i8>
        %259 = llvm.bitcast %258 : !llvm.ptr<i8> to !llvm.ptr<f32>
        %260 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %261 = llvm.insertvalue %259, %260[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %262 = llvm.insertvalue %259, %261[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %263 = llvm.mlir.constant(0 : index) : i64
        %264 = llvm.insertvalue %263, %262[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %265 = llvm.insertvalue %245, %264[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %266 = llvm.insertvalue %246, %265[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %267 = llvm.insertvalue %247, %266[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %268 = llvm.insertvalue %248, %267[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %269 = llvm.insertvalue %249, %268[3, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %270 = llvm.insertvalue %253, %269[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %271 = llvm.insertvalue %252, %270[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %272 = llvm.insertvalue %251, %271[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %273 = llvm.insertvalue %249, %272[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %274 = llvm.insertvalue %250, %273[4, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        llvm.br ^bb3(%9 : i64)
      ^bb3(%275: i64):  // 2 preds: ^bb2, ^bb13
        %276 = llvm.icmp "slt" %275, %1 : i64
        llvm.cond_br %276, ^bb4, ^bb14
      ^bb4:  // pred: ^bb3
        %277 = llvm.mlir.constant(1 : index) : i64
        %278 = llvm.mlir.constant(1 : index) : i64
        %279 = llvm.mlir.constant(1 : index) : i64
        %280 = llvm.mlir.constant(32 : index) : i64
        %281 = llvm.mlir.constant(1 : index) : i64
        %282 = llvm.mlir.constant(32 : index) : i64
        %283 = llvm.mlir.constant(32 : index) : i64
        %284 = llvm.mlir.constant(32 : index) : i64
        %285 = llvm.mlir.null : !llvm.ptr<f32>
        %286 = llvm.getelementptr %285[%284] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %287 = llvm.ptrtoint %286 : !llvm.ptr<f32> to i64
        %288 = llvm.call @malloc(%287) : (i64) -> !llvm.ptr<i8>
        %289 = llvm.bitcast %288 : !llvm.ptr<i8> to !llvm.ptr<f32>
        %290 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %291 = llvm.insertvalue %289, %290[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %292 = llvm.insertvalue %289, %291[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %293 = llvm.mlir.constant(0 : index) : i64
        %294 = llvm.insertvalue %293, %292[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %295 = llvm.insertvalue %277, %294[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %296 = llvm.insertvalue %278, %295[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %297 = llvm.insertvalue %279, %296[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %298 = llvm.insertvalue %280, %297[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %299 = llvm.insertvalue %283, %298[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %300 = llvm.insertvalue %282, %299[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %301 = llvm.insertvalue %280, %300[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %302 = llvm.insertvalue %281, %301[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %303 = llvm.mlir.constant(1 : index) : i64
        %304 = llvm.mlir.constant(1 : index) : i64
        %305 = llvm.mlir.constant(1 : index) : i64
        %306 = llvm.mlir.constant(1 : index) : i64
        %307 = llvm.mlir.constant(32 : index) : i64
        %308 = llvm.mlir.constant(1 : index) : i64
        %309 = llvm.mlir.constant(32 : index) : i64
        %310 = llvm.mlir.constant(32 : index) : i64
        %311 = llvm.mlir.constant(32 : index) : i64
        %312 = llvm.mlir.constant(32 : index) : i64
        %313 = llvm.mlir.null : !llvm.ptr<f32>
        %314 = llvm.getelementptr %313[%312] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %315 = llvm.ptrtoint %314 : !llvm.ptr<f32> to i64
        %316 = llvm.call @malloc(%315) : (i64) -> !llvm.ptr<i8>
        %317 = llvm.bitcast %316 : !llvm.ptr<i8> to !llvm.ptr<f32>
        %318 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %319 = llvm.insertvalue %317, %318[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %320 = llvm.insertvalue %317, %319[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %321 = llvm.mlir.constant(0 : index) : i64
        %322 = llvm.insertvalue %321, %320[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %323 = llvm.insertvalue %303, %322[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %324 = llvm.insertvalue %304, %323[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %325 = llvm.insertvalue %305, %324[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %326 = llvm.insertvalue %306, %325[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %327 = llvm.insertvalue %307, %326[3, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %328 = llvm.insertvalue %311, %327[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %329 = llvm.insertvalue %310, %328[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %330 = llvm.insertvalue %309, %329[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %331 = llvm.insertvalue %307, %330[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %332 = llvm.insertvalue %308, %331[4, 4] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        llvm.br ^bb5(%9 : i64)
      ^bb5(%333: i64):  // 2 preds: ^bb4, ^bb6
        %334 = llvm.icmp "slt" %333, %0 : i64
        llvm.cond_br %334, ^bb6, ^bb7
      ^bb6:  // pred: ^bb5
        %335 = llvm.extractvalue %302[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %336 = llvm.mlir.constant(32 : index) : i64
        %337 = llvm.mul %9, %336  : i64
        %338 = llvm.mlir.constant(32 : index) : i64
        %339 = llvm.mul %9, %338  : i64
        %340 = llvm.add %337, %339  : i64
        %341 = llvm.mlir.constant(32 : index) : i64
        %342 = llvm.mul %9, %341  : i64
        %343 = llvm.add %340, %342  : i64
        %344 = llvm.add %343, %333  : i64
        %345 = llvm.getelementptr %335[%344] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        llvm.store %28, %345 : !llvm.ptr<f32>
        %346 = llvm.add %333, %10  : i64
        llvm.br ^bb5(%346 : i64)
      ^bb7:  // pred: ^bb5
        llvm.br ^bb8(%9 : i64)
      ^bb8(%347: i64):  // 2 preds: ^bb7, ^bb9
        %348 = llvm.icmp "slt" %347, %0 : i64
        llvm.cond_br %348, ^bb9, ^bb10
      ^bb9:  // pred: ^bb8
        %349 = llvm.extractvalue %302[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %350 = llvm.mlir.constant(32 : index) : i64
        %351 = llvm.mul %9, %350  : i64
        %352 = llvm.mlir.constant(32 : index) : i64
        %353 = llvm.mul %9, %352  : i64
        %354 = llvm.add %351, %353  : i64
        %355 = llvm.mlir.constant(32 : index) : i64
        %356 = llvm.mul %9, %355  : i64
        %357 = llvm.add %354, %356  : i64
        %358 = llvm.add %357, %347  : i64
        %359 = llvm.getelementptr %349[%358] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %360 = llvm.load %359 : !llvm.ptr<f32>
        %361 = llvm.extractvalue %332[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %362 = llvm.mlir.constant(32 : index) : i64
        %363 = llvm.mul %9, %362  : i64
        %364 = llvm.mlir.constant(32 : index) : i64
        %365 = llvm.mul %9, %364  : i64
        %366 = llvm.add %363, %365  : i64
        %367 = llvm.mlir.constant(32 : index) : i64
        %368 = llvm.mul %9, %367  : i64
        %369 = llvm.add %366, %368  : i64
        %370 = llvm.mlir.constant(32 : index) : i64
        %371 = llvm.mul %9, %370  : i64
        %372 = llvm.add %369, %371  : i64
        %373 = llvm.add %372, %347  : i64
        %374 = llvm.getelementptr %361[%373] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        llvm.store %360, %374 : !llvm.ptr<f32>
        %375 = llvm.add %347, %10  : i64
        llvm.br ^bb8(%375 : i64)
      ^bb10:  // pred: ^bb8
        %376 = llvm.extractvalue %302[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %377 = llvm.bitcast %376 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @free(%377) : (!llvm.ptr<i8>) -> ()
        llvm.br ^bb11(%9 : i64)
      ^bb11(%378: i64):  // 2 preds: ^bb10, ^bb12
        %379 = llvm.icmp "slt" %378, %0 : i64
        llvm.cond_br %379, ^bb12, ^bb13
      ^bb12:  // pred: ^bb11
        %380 = llvm.extractvalue %332[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %381 = llvm.mlir.constant(32 : index) : i64
        %382 = llvm.mul %9, %381  : i64
        %383 = llvm.mlir.constant(32 : index) : i64
        %384 = llvm.mul %9, %383  : i64
        %385 = llvm.add %382, %384  : i64
        %386 = llvm.mlir.constant(32 : index) : i64
        %387 = llvm.mul %9, %386  : i64
        %388 = llvm.add %385, %387  : i64
        %389 = llvm.mlir.constant(32 : index) : i64
        %390 = llvm.mul %9, %389  : i64
        %391 = llvm.add %388, %390  : i64
        %392 = llvm.add %391, %378  : i64
        %393 = llvm.getelementptr %380[%392] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %394 = llvm.load %393 : !llvm.ptr<f32>
        %395 = llvm.extractvalue %274[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %396 = llvm.mlir.constant(1792 : index) : i64
        %397 = llvm.mul %9, %396  : i64
        %398 = llvm.mlir.constant(1792 : index) : i64
        %399 = llvm.mul %9, %398  : i64
        %400 = llvm.add %397, %399  : i64
        %401 = llvm.mlir.constant(1792 : index) : i64
        %402 = llvm.mul %9, %401  : i64
        %403 = llvm.add %400, %402  : i64
        %404 = llvm.mlir.constant(32 : index) : i64
        %405 = llvm.mul %275, %404  : i64
        %406 = llvm.add %403, %405  : i64
        %407 = llvm.add %406, %378  : i64
        %408 = llvm.getelementptr %395[%407] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        llvm.store %394, %408 : !llvm.ptr<f32>
        %409 = llvm.add %378, %10  : i64
        llvm.br ^bb11(%409 : i64)
      ^bb13:  // pred: ^bb11
        %410 = llvm.extractvalue %332[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %411 = llvm.bitcast %410 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @free(%411) : (!llvm.ptr<i8>) -> ()
        %412 = llvm.add %275, %10  : i64
        llvm.br ^bb3(%412 : i64)
      ^bb14:  // pred: ^bb3
        %413 = llvm.add %243, %241  : i64
        %414 = llvm.extractvalue %101[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %415 = llvm.mlir.constant(200704 : index) : i64
        %416 = llvm.mul %9, %415  : i64
        %417 = llvm.mlir.constant(100352 : index) : i64
        %418 = llvm.mul %9, %417  : i64
        %419 = llvm.add %416, %418  : i64
        %420 = llvm.mlir.constant(1792 : index) : i64
        %421 = llvm.mul %413, %420  : i64
        %422 = llvm.add %419, %421  : i64
        %423 = llvm.mlir.constant(32 : index) : i64
        %424 = llvm.mul %9, %423  : i64
        %425 = llvm.add %422, %424  : i64
        %426 = llvm.add %425, %9  : i64
        %427 = llvm.getelementptr %414[%426] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %428 = llvm.extractvalue %152[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
        %429 = llvm.mlir.constant(2048 : index) : i64
        %430 = llvm.mul %9, %429  : i64
        %431 = llvm.mlir.constant(1024 : index) : i64
        %432 = llvm.mul %239, %431  : i64
        %433 = llvm.add %430, %432  : i64
        %434 = llvm.mlir.constant(1024 : index) : i64
        %435 = llvm.mul %9, %434  : i64
        %436 = llvm.add %433, %435  : i64
        %437 = llvm.mlir.constant(1024 : index) : i64
        %438 = llvm.mul %9, %437  : i64
        %439 = llvm.add %436, %438  : i64
        %440 = llvm.mlir.constant(32 : index) : i64
        %441 = llvm.mul %9, %440  : i64
        %442 = llvm.add %439, %441  : i64
        %443 = llvm.add %442, %9  : i64
        %444 = llvm.getelementptr %428[%443] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %445 = llvm.extractvalue %274[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %446 = llvm.mlir.constant(1792 : index) : i64
        %447 = llvm.mul %9, %446  : i64
        %448 = llvm.mlir.constant(1792 : index) : i64
        %449 = llvm.mul %9, %448  : i64
        %450 = llvm.add %447, %449  : i64
        %451 = llvm.mlir.constant(1792 : index) : i64
        %452 = llvm.mul %9, %451  : i64
        %453 = llvm.add %450, %452  : i64
        %454 = llvm.mlir.constant(32 : index) : i64
        %455 = llvm.mul %9, %454  : i64
        %456 = llvm.add %453, %455  : i64
        %457 = llvm.add %456, %9  : i64
        %458 = llvm.getelementptr %445[%457] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %459 = llvm.mlir.constant(2 : i64) : i64
        %460 = llvm.mlir.addressof @brgemm_aoffsets0 : !llvm.ptr<array<2 x i64>>
        %461 = llvm.mlir.addressof @brgemm_boffsets0 : !llvm.ptr<array<2 x i64>>
        %462 = llvm.mlir.constant(0 : index) : i64
        %463 = llvm.mlir.constant(0 : index) : i64
        %464 = llvm.getelementptr %460[%462, %462] : (!llvm.ptr<array<2 x i64>>, i64, i64) -> !llvm.ptr<i64>
        %465 = llvm.getelementptr %461[%463, %463] : (!llvm.ptr<array<2 x i64>>, i64, i64) -> !llvm.ptr<i64>
        llvm.call @plaidml_rt_xsmm_brgemm_offs_invoke_f32(%207, %427, %444, %458, %459, %464, %465) : (i64, !llvm.ptr<f32>, !llvm.ptr<f32>, !llvm.ptr<f32>, i64, !llvm.ptr<i64>, !llvm.ptr<i64>) -> ()
        %466 = llvm.extractvalue %274[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %467 = llvm.mlir.constant(1792 : index) : i64
        %468 = llvm.mul %9, %467  : i64
        %469 = llvm.mlir.constant(1792 : index) : i64
        %470 = llvm.mul %9, %469  : i64
        %471 = llvm.add %468, %470  : i64
        %472 = llvm.mlir.constant(1792 : index) : i64
        %473 = llvm.mul %9, %472  : i64
        %474 = llvm.add %471, %473  : i64
        %475 = llvm.mlir.constant(32 : index) : i64
        %476 = llvm.mul %9, %475  : i64
        %477 = llvm.add %474, %476  : i64
        %478 = llvm.add %477, %9  : i64
        %479 = llvm.getelementptr %466[%478] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %480 = llvm.bitcast %479 : !llvm.ptr<f32> to !llvm.ptr<i8>
        %481 = llvm.extractvalue %197[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
        %482 = llvm.mlir.constant(200704 : index) : i64
        %483 = llvm.mul %9, %482  : i64
        %484 = llvm.mlir.constant(3584 : index) : i64
        %485 = llvm.mul %413, %484  : i64
        %486 = llvm.add %483, %485  : i64
        %487 = llvm.mlir.constant(64 : index) : i64
        %488 = llvm.mul %9, %487  : i64
        %489 = llvm.add %486, %488  : i64
        %490 = llvm.add %489, %242  : i64
        %491 = llvm.getelementptr %481[%490] : (!llvm.ptr<f32>, i64) -> !llvm.ptr<f32>
        %492 = llvm.bitcast %491 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @plaidml_rt_xsmm_unary_invoke(%217, %480, %492) : (i64, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
        %493 = llvm.extractvalue %274[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
        %494 = llvm.bitcast %493 : !llvm.ptr<f32> to !llvm.ptr<i8>
        llvm.call @free(%494) : (!llvm.ptr<i8>) -> ()
        %495 = llvm.add %243, %10  : i64
        llvm.br ^bb1(%495 : i64)
      ^bb15:  // pred: ^bb1
        omp.yield
      }
      omp.terminator
    }
    llvm.intr.stackrestore %218
    %219 = llvm.mlir.addressof @__loc_str_7 : !llvm.ptr<array<30 x i8>>
    %220 = llvm.mlir.constant(0 : index) : i64
    %221 = llvm.getelementptr %219[%220, %220] : (!llvm.ptr<array<30 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @plaidml_rt_instrument(%5, %3, %221) : (i64, i64, !llvm.ptr<i8>) -> ()
    %222 = llvm.extractvalue %152[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<6 x i64>, array<6 x i64>)>
    %223 = llvm.bitcast %222 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%223) : (!llvm.ptr<i8>) -> ()
    %224 = llvm.extractvalue %101[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<5 x i64>, array<5 x i64>)>
    %225 = llvm.bitcast %224 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%225) : (!llvm.ptr<i8>) -> ()
    %226 = llvm.extractvalue %197[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %227 = llvm.extractvalue %197[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %228 = llvm.extractvalue %197[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %229 = llvm.extractvalue %197[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %230 = llvm.extractvalue %197[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %231 = llvm.extractvalue %197[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %232 = llvm.extractvalue %197[3, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %233 = llvm.extractvalue %197[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %234 = llvm.extractvalue %197[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %235 = llvm.extractvalue %197[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %236 = llvm.extractvalue %197[4, 3] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    // llvm.call @print_memref_f32(%226, %227, %228, %229, %230, %231, %232, %233, %234, %235, %236) : (!llvm.ptr<f32>, !llvm.ptr<f32>, i64, i64, i64, i64, i64, i64, i64, i64, i64) -> ()
    %237 = llvm.extractvalue %197[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<4 x i64>, array<4 x i64>)>
    %238 = llvm.bitcast %237 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%238) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @_mlir_ciface_prospar() {
    llvm.call @prospar() : () -> ()
    llvm.return
  }
}

