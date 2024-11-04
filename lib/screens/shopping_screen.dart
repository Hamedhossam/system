import 'package:flutter/material.dart';
import 'package:motors/views/shopping_screen/check_out_view.dart';
import 'package:motors/views/shopping_screen/shopping_view.dart';
import 'package:motors/widgets/vertical_line.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: MediaQuery.sizeOf(context).width * .70,
            child: const ShoppingView()),
        const CustomizedVerticalLine(),
        const Expanded(child: CheckOutView()),
      ],
    );
  }
}
