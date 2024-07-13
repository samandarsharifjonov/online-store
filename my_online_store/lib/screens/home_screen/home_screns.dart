import 'package:flutter/material.dart';
import 'package:my_shop/screens/draver/app_drawer.dart';
import 'package:my_shop/widgets/cutom_cart.dart';

import 'package:my_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';


import '../../providers/cart/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomeScreens extends StatefulWidget {
  HomeScreens({super.key});

  static const routName = "/";

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  bool _showOnlyFavorites = false;



  @override
  Widget build(BuildContext context) {
    print('Bulid, HomeScreen');
    //final cartCount = Provider.of<Cart>(context, listen: false).itemsCount();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert_outlined, color: Colors.white,),
              onSelected: (value) {
                setState(() {
                  if (FilterOptions.All == value) {
                    _showOnlyFavorites = false;
                  } else {
                    _showOnlyFavorites = true;
                  }
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child:  Text("Barchasi"),
                    value: FilterOptions.All,
                  ),
                  const PopupMenuItem(
                    child: Text("Sevimlilar"),
                    value: FilterOptions.Favorites,

                  ),
                ];
              },
            ),
            Consumer<Cart>(
                builder: (context, value, child) => CustomCart(
                    icon: const Icon(Icons.shopping_cart_sharp),
                    number: value.itemsCount().toString())),
          ],
          title: const Text(
            "MacBRO MARKET",
            style: TextStyle(fontSize: 25,color: Colors.white),
          ),
        ),
        drawer: const AppDrawer(),
        body: ProductGrid(
          favorites: _showOnlyFavorites,
        ));
  }
}
