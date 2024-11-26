import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedVerticalLine extends StatelessWidget {
  const CustomizedVerticalLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: const Color.fromARGB(94, 0, 0, 0), // Line color
      thickness: 2, // Line thickness
      width: 5.w, // Space from the text
    );
  }
}
