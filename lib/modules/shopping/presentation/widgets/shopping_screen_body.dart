import 'package:flutter/material.dart';
import 'package:motors/core/widgets/vertical_line.dart';
import 'package:motors/modules/shopping/presentation/screens/check_out_view.dart';
import 'package:motors/modules/shopping/presentation/screens/shopping_view.dart';

class ShoppingScreenBody extends StatelessWidget {
  const ShoppingScreenBody({super.key});

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
