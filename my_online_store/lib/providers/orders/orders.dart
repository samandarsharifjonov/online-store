import 'package:flutter/cupertino.dart';

import '../../models/card_item.dart';
import '../../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  void addToOrders(List<CartItem> products, double totalPrice) {
    _items.insert(
        0,
        Order(
            id: UniqueKey().toString(),
            totalPrice: totalPrice,
            date: DateTime.now(),
            products: products));
    notifyListeners();
  }

}
