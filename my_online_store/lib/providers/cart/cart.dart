import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_shop/models/card_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  double totalPrice() {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addToCart(String productId, String title, String imgUrl, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (currentProduct) => CartItem(
            id: currentProduct.id,
            title: currentProduct.title,
            quantity: currentProduct.quantity + 1,
            price: currentProduct.price,
            imgUrl: currentProduct.imgUrl),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: UniqueKey().toString(),
            title: title,
            quantity: 1,
            price: price,
            imgUrl: imgUrl),
      );
    }
    notifyListeners();
  }

  void delete(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId, {bool isCartButton = false}) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              imgUrl: value.imgUrl,
              price: value.price,
              quantity: value.quantity - 1,
              title: value.title));
    } else if (isCartButton) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void cartClear() {
    _items.clear();
    notifyListeners();
  }
}
