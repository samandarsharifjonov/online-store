import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../providers/cart/cart.dart';

class CartListItem extends StatelessWidget {
  final String productId;
  final String img;
  final String title;
  final double price;
  final int quantity;

  const CartListItem(
      {super.key,
      required this.productId,
      required this.img,
      required this.title,
      required this.price,
      required this.quantity});

  void showMyDialog(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: false,
          title:  Text(title),
          content:  Text("${title}ni rostan ham o'chirmoqchimisiz?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("BEKOR QILISH")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
                    
              ),
                onPressed: () {
                  removeItem();
                  Navigator.of(context).pop();
                },
                child: const Text("O'chirish", ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return  Slidable(
      key: ValueKey(productId),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
           Expanded(
             child: Padding(
               padding: const EdgeInsets.all(5.0),
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.red,
                   shape: BeveledRectangleBorder(
                     borderRadius: BorderRadius.circular(4)
                   ),
                   padding: const EdgeInsets.symmetric(
                     horizontal: 20,
                     vertical: 23,
                   )

                 ),
                   onPressed: () {
                 showMyDialog(context, () {
                   cart.delete(productId);
                 });
               }, child: const Text("O'chirish")),
             ),
           )
        ],
      ),
        child: Card(
          child: ListTile(
            leading: Container(
              height: 150,
              width: 80,
              child: CachedNetworkImage(
                imageUrl: img, fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                /*errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red,),*/
              ),
            ),
            title: Text(title),
            subtitle: Text("\$${(price * quantity).toStringAsFixed(2)}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    splashRadius: 5,
                    onPressed: () => cart.removeSingleItem(productId),
                    icon: const Icon(Icons.remove)),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.1)),
                  child: Text("${quantity.toString()}"),
                ),
                IconButton(
                    onPressed: () => cart.addToCart(productId, title, img, price),
                    icon: const Icon(Icons.add))
              ],
            ),
          ),
        ),
    );
  }
}
