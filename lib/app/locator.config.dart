// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mobile_store/app/locator.dart' as _i12;
import 'package:mobile_store/data/data_sources/product_local_data_source.dart'
    as _i8;
import 'package:mobile_store/data/data_sources/product_remote_data_source.dart'
    as _i10;
import 'package:mobile_store/data/repositories/product_repository_impl.dart'
    as _i11;
import 'package:mobile_store/domain/repositories/product_repository.dart'
    as _i5;
import 'package:mobile_store/domain/use_case/get_product_use_case.dart' as _i4;
import 'package:mobile_store/domain/use_case/update_product_use_case.dart'
    as _i7;
import 'package:mobile_store/presentation/cubit/product_cubit.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i4.GetProductUseCase>(
        () => _i4.GetProductUseCase(gh<_i5.ProductRepository>()));
    gh.factory<_i6.ProductCubit>(() => _i6.ProductCubit(
          getProductUseCase: gh<_i4.GetProductUseCase>(),
          updateProductUseCase: gh<_i7.UpdateProductUseCase>(),
        ));
    gh.lazySingleton<_i8.ProductLocalDataSource>(() =>
        _i8.ProductLocalDataSourceImpl(
            sharedPreferences: gh<_i9.SharedPreferences>()));
    gh.lazySingleton<_i10.ProductRemoteDataSource>(
        () => _i10.ProductRemoteDataSourceImpl(dio: gh<_i3.Dio>()));
    gh.lazySingleton<_i5.ProductRepository>(() => _i11.ProductRepositoryImpl(
          productLocalDataSource: gh<_i8.ProductLocalDataSource>(),
          productRemoteDataSource: gh<_i10.ProductRemoteDataSource>(),
        ));
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i7.UpdateProductUseCase>(
        () => _i7.UpdateProductUseCase(gh<_i5.ProductRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i12.RegisterModule {}
