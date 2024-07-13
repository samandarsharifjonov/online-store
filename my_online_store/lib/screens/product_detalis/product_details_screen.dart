import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_shop/providers/products/products.dart';
import 'package:my_shop/screens/card/cart_screen.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';
import '../../providers/cart/cart.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  static const routName = "/product-details";

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments;
    final product = Provider.of<Products>(context, listen: false)
        .findById(productId as String);



    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          /* const Divider(
            height: 0.5,
          ),*/
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: product.imgUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child:  Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                height: 40,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      product.title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text("Description",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(product.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                )),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.teal,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Narxi:",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "\$ ${product.price.toString()}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Consumer<Cart>(
                builder: (BuildContext context, value, child) {
                    return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.green,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      label: const Text(
                        "Savatchaga borish",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, CartScreen.routName);
                      },
                    );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
