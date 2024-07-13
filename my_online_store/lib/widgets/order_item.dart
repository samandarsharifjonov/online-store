import 'package:flutter/material.dart';


import '../models/card_item.dart';


class OrderItem extends StatefulWidget {
  final String totalPrice;
  final String dataTime;
  final List<CartItem> products;

  const OrderItem(
      {super.key,
      required this.totalPrice,
      required this.dataTime,
      required this.products});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

bool _expendItem = false;

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        ListTile(
          title: Text("\$${widget.totalPrice}"),
          subtitle: Text(widget.dataTime),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                _expendItem = !_expendItem;
              });
            },
            icon: Icon(_expendItem ? Icons.expand_less : Icons.expand_more),
          ),
        ),
        if (_expendItem)
          Container(
            height: 200,
            //color: Colors.teal,
            child: ListView.builder(
              itemExtent: 30,
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.products[index].title),
                  trailing: Text(
                      "${widget.products[index].quantity}x \$${widget.products[index].price * widget.products[index].quantity}"),
                );
              },
            ),
          ),
      ]),
    );
  }
}
