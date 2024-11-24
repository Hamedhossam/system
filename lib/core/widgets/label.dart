import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Label extends StatelessWidget {
  const Label({
    required this.tittle,
    super.key,
  });
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return Text(
      tittle,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
    );
  }
}
