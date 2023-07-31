import 'package:dartz/dartz.dart';
import 'package:mobile_store/app/failures.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Product>>> updateProducts(
      {required Product product});
}
