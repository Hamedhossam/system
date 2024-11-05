import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';

class ShoppingCartLabel extends StatelessWidget {
  const ShoppingCartLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 40,
            width: 40,
            child: Image.asset("assets/icons/shopping_cart.png")),
        const Label(tittle: " Cart"),
      ],
    );
  }
}
