part of 'product_cubit.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(BlocStatus.loading) status,
    @Default([]) List<Product> products,
    @Default("") String message,
  }) = _ProductState;
}
