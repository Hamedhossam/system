import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            height: 40.h,
            width: 40.w,
            child: Image.asset("assets/icons/shopping_cart.png")),
        const Label(tittle: " Cart"),
      ],
    );
  }
}
