import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/screens/product_detalis/product_details_screen.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart/cart.dart';


class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final productDada = Provider.of<Product>(context, listen: false);
    final cartData = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailsScreen.routName,
                  arguments: productDada.id);
            },
            child: CachedNetworkImage(
              imageUrl: productDada.imgUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: const CircularProgressIndicator(),
                ),
              ),
            /*  errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error, color: Colors.red,),
              ),*/
            )),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              icon: Icon(value.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onPressed: value.toggleLike,
              color: Colors.teal,
            ),
          ),
          title: Text(
            productDada.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Consumer<Cart>(
            builder: (context, value, child) {
              return IconButton(
                color: Colors.teal,
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  cartData.addToCart(productDada.id, productDada.title,
                      productDada.imgUrl!, productDada.price);

                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                          content: const Text("Savatchaga qo'shildi"),
                          actions: [
                        TextButton(
                            onPressed: () {
                              cartData.removeSingleItem(productDada.id,
                                  isCartButton: true);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                            },
                            child: const Text("BEKOR QILISH"))
                      ]));

                  Future.delayed(const Duration(seconds: 2)).then(
                    (value) => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                  );

                  //--------------------------------------------------------------
                  /* ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: const Text("Savatchaga qo'shildi"),
                      action: SnackBarAction(
                        label: "BEKOR QILISH",
                        onPressed: () {
                          cartData.removeSingleItem(productDada.id, isCartButton: true);
                        },
                      ),
                    ),
                  );*/
                  //--------------------------------------------------------------------
                },
              );
            },
          ),
          backgroundColor: Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }
}
