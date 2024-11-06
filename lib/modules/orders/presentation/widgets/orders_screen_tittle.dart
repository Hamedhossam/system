import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';

class OrdersScreenTittle extends StatelessWidget {
  const OrdersScreenTittle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: SizedBox(
              height: 40,
              width: 40,
              child: Image.asset("assets/icons/orders.png")),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Label(tittle: "Orders"),
        ),
      ],
    );
  }
}
