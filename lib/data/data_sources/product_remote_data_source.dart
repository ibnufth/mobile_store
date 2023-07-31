import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_store/app/exception.dart';
import 'package:mobile_store/app/locator.dart';

import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;
  ProductRemoteDataSourceImpl({Dio? dio}) : _dio = dio ?? getIt();
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('https://dummyjson.com/products');
    if (response.statusCode != 200) {
      throw ServerException(message: "Failed to get products");
    }
    final data = response.data['products'];

    List<ProductModel> products =
        (data as List).map((e) => ProductModel.fromMap(e)).toList();
    return products;
  }
}
