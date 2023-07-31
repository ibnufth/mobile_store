import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies()  =>  getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
