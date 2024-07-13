import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String? imgUrl;
  final double price;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imgUrl,
      this.isFavorite = false});

   void toggleLike(){
     isFavorite = !isFavorite;
     notifyListeners();
   }
}
