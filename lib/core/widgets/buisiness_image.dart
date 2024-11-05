import 'package:flutter/material.dart';

class BuisinessImage extends StatelessWidget {
  const BuisinessImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Image.asset(
          "assets/icons/store_logo.png",
        ),
      ),
    );
  }
}
