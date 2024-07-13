import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/edit_product_screen/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/products/products.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Container(
            height: 150,
            width: 80,
            child: CachedNetworkImage(
              imageUrl: product.imgUrl!,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(
                  height: 5,
                  width: 5,
                  child: Container(
                      height: 10,
                      width: 10,
                      child: const CircularProgressIndicator())),
              errorWidget: (context, url, error) =>
                  const Center(child:  Text("Rasim yo'q")),
            ),
          ),
          title: Text(product.title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditProductScreen.routName, arguments: product.id);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(product.id);
              }, icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
