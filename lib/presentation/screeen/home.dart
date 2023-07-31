import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store/presentation/screeen/detail_product_screen.dart';

import '../../app/bloc_status.dart';
import '../../domain/entities/product.dart';
import '../cubit/product_cubit.dart';

class HomeScreen extends StatefulWidget {
  static const pageName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status == BlocStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == BlocStatus.error) {
              return Center(
                child: Column(
                  children: [
                    Text("Terjadi kesalahan", style: textStyle.titleLarge),
                    Text(state.message),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                Product product = state.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailProductScreen.pageName,
                      arguments: {DetailProductScreen.productArgs: product},
                    );
                  },
                  child: Container(
                    key: ObjectKey(product),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenSize.width * .25,
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${product.thumbnail}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  child: Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    context
                                        .read<ProductCubit>()
                                        .setFavorite(product: product);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: screenSize.width * .5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.title}",
                                style: textStyle.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${product.description}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "USD ${product.price}",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle.bodyLarge,
                                  ),
                                  Text(
                                    " ${product.discountPercentage}% off",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle.bodyMedium
                                        ?.copyWith(color: Colors.orange),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
