import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/failures.dart';
import '../../app/locator.dart';
import '../../app/use_case.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class UpdateProductUseCase implements UseCase<List<Product>, Product> {
  final ProductRepository _productRepository;

  UpdateProductUseCase(ProductRepository? productRepository)
      : _productRepository = productRepository ?? getIt<ProductRepository>();

  @override
  Future<Either<Failure, List<Product>>> call(Product params) {
    return _productRepository.updateProducts(product: params);
  }
}
