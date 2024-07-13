import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart/cart.dart';
import 'package:my_shop/providers/orders/orders.dart';
import 'package:my_shop/providers/products/products.dart';
import 'package:my_shop/screens/card/cart_screen.dart';
import 'package:my_shop/screens/edit_product_screen/edit_product_screen.dart';
import 'package:my_shop/screens/home_screen/home_screns.dart';
import 'package:my_shop/screens/mage_product/mange_product_screen.dart';
import 'package:my_shop/screens/order/orders_screen.dart';
import 'package:my_shop/screens/product_detalis/product_details_screen.dart';
import 'package:my_shop/styile/text_fonts.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (context) => Products()),
        ChangeNotifierProvider<Cart>(create: (context) => Cart()),
        ChangeNotifierProvider<Orders>(create: (context) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Fonts.fonts,
        initialRoute: HomeScreens.routName,
        routes: {
          HomeScreens.routName: (context) =>  HomeScreens(),
          ProductDetailsScreen.routName: (context) => const ProductDetailsScreen(),
          CartScreen.routName: (context) => const CartScreen(),
          OrdersScreen.routName: (context) => const OrdersScreen(),
          MangeProductScreen.routName: (context) => const MangeProductScreen(),
          EditProductScreen.routName: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}

