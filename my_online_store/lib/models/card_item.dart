import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier{
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imgUrl});
}
