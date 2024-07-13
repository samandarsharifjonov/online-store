import 'package:flutter/material.dart';
import 'package:my_shop/providers/products/products.dart';
import 'package:my_shop/screens/draver/app_drawer.dart';
import 'package:my_shop/screens/edit_product_screen/edit_product_screen.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class MangeProductScreen extends StatelessWidget {
  const MangeProductScreen({super.key});

  static const routName = "/mange-product-screen";

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Mahsulotlarnoi boshqarish", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed((context), EditProductScreen.routName);
          }, icon: const Icon(Icons.add, size: 30, color: Colors.white,))
        ],
      ),
      body: ListView.builder(
        itemCount: products.list.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(value: products.list[index] , child: const UserProductItem());
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
