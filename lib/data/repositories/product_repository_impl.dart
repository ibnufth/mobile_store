import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_store/app/exception.dart';
import '../../app/failures.dart';
import '../../app/locator.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../model/product_model.dart';
import '../../domain/entities/product.dart';

import '../../domain/repositories/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource _productLocalDataSource;
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(
      {ProductLocalDataSource? productLocalDataSource,
      ProductRemoteDataSource? productRemoteDataSource})
      : _productLocalDataSource = productLocalDataSource ?? getIt(),
        _productRemoteDataSource = productRemoteDataSource ?? getIt();

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final List<ProductModel> products =
          await _productRemoteDataSource.getProducts();
      await _productLocalDataSource.addProducts(products);
      return Right(products.map((e) => e.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.toString()));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> updateProducts(
      {required Product product}) async {
    try {
      final List<ProductModel> products = [
        ...await _productLocalDataSource.getProducts()
      ];
      int productIndex =
          products.indexWhere((element) => element.id == product.id);

      products.removeAt(productIndex);
      products.insert(productIndex, ProductModel.fromEntity(product));

      await _productLocalDataSource.addProducts(products);
      return Right(products.map((e) => e.toEntity()).toList());
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
