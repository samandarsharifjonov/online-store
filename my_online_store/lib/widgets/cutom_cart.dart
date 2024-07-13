import 'package:flutter/material.dart';
import 'package:my_shop/screens/card/cart_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart/cart.dart';



class CustomCart extends StatelessWidget {
  final Icon icon;
  final String number;
  const CustomCart({super.key, required this.icon, required this.number});

  @override
  Widget build(BuildContext context) {
    final productCount = Provider.of<Cart>(context).itemsCount();
    return Consumer(
      builder: (context, value, child) => Stack(
          children: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, CartScreen.routName);
            }, icon:  const Icon(Icons.shopping_cart_sharp, color: Colors.white,)),
            productCount > 0 ? Positioned(
              top: 0,
              left: 15,
              child: Container(
                height: 15,
                width: 15,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                ),
                child: Center(child: Text(number, style: const TextStyle(fontSize: 10),)),
              ),
            ) : const Text("")
          ],
        ),
    );

  }
}
