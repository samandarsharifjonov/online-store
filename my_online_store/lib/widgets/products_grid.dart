import 'package:flutter/material.dart';
import 'package:my_shop/providers/products/products.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class ProductGrid extends StatelessWidget {
  bool favorites;
  ProductGrid({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<Products>(context);
    final products =  favorites ?  productsData.favorites() : productsData.list;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider<Product>.value(
            value: products[index], child: const ProductItem());
      },
    );
  }
}
