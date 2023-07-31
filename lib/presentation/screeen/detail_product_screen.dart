// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_store/domain/entities/product.dart';
import 'package:mobile_store/presentation/cubit/product_cubit.dart';

class DetailProductScreen extends StatefulWidget {
  static const pageName = '/detail/product';
  static const productArgs = 'product';
  final Product product;
  const DetailProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.product.title}"),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          Product product = state.products.firstWhere(
            (element) => element.id == widget.product.id,
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    height: screenSize.height * .3,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        "${product.thumbnail}",
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
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "USD ${product.price}",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleMedium,
                  ),
                  Text(
                    " ${product.discountPercentage}% off",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleSmall?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${product.rating}",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleSmall?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Stock:"),
                  const SizedBox(width: 10),
                  Text(
                    "${product.stock}",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleSmall?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Brand:"),
                  const SizedBox(width: 10),
                  Text(
                    "${product.brand}",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleSmall?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text("Category:"),
                  const SizedBox(width: 10),
                  Text(
                    "${product.category}",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleSmall?.copyWith(color: Colors.orange),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Description: ",
              ),
              Text(
                "${product.description}",
              ),
              const SizedBox(height: 15),
              GridView.count(
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...(product.images != null
                      ? product.images!
                          .map(
                            (e) => SizedBox(
                              width: screenSize.width * .35,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      Image.network(e, fit: BoxFit.fitWidth)),
                            ),
                          )
                          .toList()
                      : [const SizedBox()])
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
