import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/providers/orders/orders.dart';

import 'package:my_shop/screens/draver/app_drawer.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';




class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routName = "/ordersScreen";

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Sizning buyurtmalaringiz"),
      ),
      drawer: const AppDrawer(),
      body:  ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (context, index) {
          final order = orders.items[index];
          return OrderItem(
              totalPrice: order.totalPrice.toStringAsFixed(2),
              dataTime: DateFormat("dd/mm/yyyy hh:mm").format(order.date),
            products: order.products,

          );
        },
      ),
    );
  }
}
