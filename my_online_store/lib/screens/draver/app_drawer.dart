import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen/home_screns.dart';
import 'package:my_shop/screens/mage_product/mange_product_screen.dart';
import 'package:my_shop/screens/order/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Column(
        children: [
         AppBar(
           automaticallyImplyLeading: false,
           backgroundColor: Colors.teal,
           title: const Text("Salom do'stim"),
         ),
          ListTile(
            leading:  const Icon(Icons.shop),
            title: const Text("Magazin"),
            onTap: () => Navigator.of(context).pushReplacementNamed(HomeScreens.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.card_travel),
            title: const Text("Buyurtmalar"),
            onTap: () => Navigator.of(context).pushNamed(OrdersScreen.routName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Mahsulotni boshqarish"),
            onTap: (){
              Navigator.of(context).pushNamed(MangeProductScreen.routName);
            },
          ),
           const Divider()
        ],
      ),
    );
  }
}
