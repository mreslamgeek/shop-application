import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as or;

class OrderItem extends StatefulWidget {
  final or.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 110, 250) : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  //we you exclamation mark to inverse this value
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            // if (_expanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 15, 150)
                  : 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                height: min(
                  widget.order.products.length * 20.0 + 15,
                  150,
                ),
                child: ListView(
                  children: widget.order.products
                      .map(
                        (prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                prod.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${prod.quantity}x \$${prod.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
