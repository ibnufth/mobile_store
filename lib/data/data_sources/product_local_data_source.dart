import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/exception.dart';
import '../../app/locator.dart';
import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> addProducts(List<ProductModel> products);
  Future<List<ProductModel>> getProducts();
}

@LazySingleton(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences _sharedPreferences;

  ProductLocalDataSourceImpl({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? getIt();
  @override
  Future<void> addProducts(List<ProductModel> products) async {
    await _sharedPreferences.setStringList(
        'products', products.map((e) => e.toJson()).toList());
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final List<String>? jsonData = _sharedPreferences.getStringList('products');
    if (jsonData == null) {
      throw CacheException(message: "Gagal mengambil data");
    }
    return jsonData.map((e) => ProductModel.fromJson(e)).toList();
  }
}
