import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_store/app/bloc_status.dart';
import 'package:mobile_store/app/locator.dart';
import 'package:mobile_store/app/use_case.dart';
import 'package:mobile_store/domain/use_case/get_product_use_case.dart';
import 'package:mobile_store/domain/use_case/update_product_use_case.dart';

import '../../domain/entities/product.dart';

part 'product_cubit.freezed.dart';
part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductUseCase _getProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;

  ProductCubit(
      {GetProductUseCase? getProductUseCase,
      UpdateProductUseCase? updateProductUseCase})
      : _getProductUseCase = getProductUseCase ?? getIt(),
        _updateProductUseCase = updateProductUseCase ?? getIt(),
        super(const ProductState());

  Future<void> getProduct() async {
    emit(state.copyWith(status: BlocStatus.loading));
    final result = await _getProductUseCase(NoParams());
    result.fold((l) {
      emit(state.copyWith(message: l.message, status: BlocStatus.error));
    }, (r) {
      emit(state.copyWith(products: r, status: BlocStatus.success));
    });
  }

  Future<void> setFavorite({required Product product}) async {
    // emit(state.copyWith(status: BlocStatus.loading));
    final result = await _updateProductUseCase(
        product.copyWith(isFavorite: !product.isFavorite));
    result.fold((l) {
      emit(state.copyWith(message: l.message, status: BlocStatus.error));
    }, (r) {
      emit(state.copyWith(products: r, status: BlocStatus.success));
      log("r $r");
    });
  }
}
