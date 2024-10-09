import 'package:flutter/material.dart';

class CustomizedVerticalLine extends StatelessWidget {
  const CustomizedVerticalLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: Color.fromARGB(94, 0, 0, 0), // Line color
      thickness: 2, // Line thickness
      width: 5, // Space from the text
    );
  }
}
