import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';

class OrdersLabel extends StatelessWidget {
  const OrdersLabel({
    super.key,
    required this.tittle,
  });
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
      child: Row(children: [
        SizedBox(width: 150, child: Label(tittle: tittle)),
      ]),
    );
  }
}
