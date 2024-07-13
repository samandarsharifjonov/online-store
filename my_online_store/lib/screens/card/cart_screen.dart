import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders/orders.dart';
import 'package:my_shop/screens/order/orders_screen.dart';
import 'package:my_shop/widgets/cart_list_item.dart';
import 'package:provider/provider.dart';

import '../../providers/cart/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routName = "/cart-screen";

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    //final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Sizning svatchangiz",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Umumiy: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    backgroundColor: Colors.teal,
                    label: Text(
                      "\$ ${cartData.totalPrice().toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, OrdersScreen.routName);
                        Provider.of<Orders>(context, listen: false).addToOrders(
                            cartData.items.values.toList(),
                            cartData.totalPrice());
                        cartData.cartClear();
                      },
                      child: const Text(
                        "BUYURTMA QILISH",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (context, index) {
                final cartItem = cartData.items.values.toList()[index];
                return CartListItem(
                    productId: cartData.items.keys.toList()[index],
                    img: cartItem.imgUrl,
                    title: cartItem.title,
                    price: cartItem.price,
                    quantity: cartItem.quantity);
              },
            ),
          )
        ],
      ),
    );
  }
}
