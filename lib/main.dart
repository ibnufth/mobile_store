import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/domain/entities/product.dart';
import 'package:mobile_store/presentation/cubit/product_cubit.dart';
import 'package:mobile_store/presentation/screeen/detail_product_screen.dart';
import 'package:mobile_store/presentation/screeen/home.dart';

import 'app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit()..getProduct(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          if (settings.name == HomeScreen.pageName) {
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          }
          if (settings.name == DetailProductScreen.pageName) {
            return MaterialPageRoute(
              builder: (context) => DetailProductScreen(
                product: (arguments as Map)[DetailProductScreen.productArgs],
              ),
            );
          }

          return null;
        },
        home: const HomeScreen(),
      ),
    );
  }
}
