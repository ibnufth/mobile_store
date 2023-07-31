import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../app/failures.dart';
import '../../app/locator.dart';
import '../../app/use_case.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductUseCase implements UseCase<List<Product>, NoParams> {
  final ProductRepository _productRepository;

  GetProductUseCase(ProductRepository? productRepository)
      : _productRepository = productRepository ?? getIt<ProductRepository>();

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return _productRepository.getProducts();
  }
}
