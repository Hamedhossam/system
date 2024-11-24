import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedButton extends StatelessWidget {
  const CustomizedButton({
    super.key,
    this.onTap,
    required this.tittle,
    required this.myColor,
  });
  final void Function()? onTap;
  final String tittle;
  final Color myColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * .230,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            tittle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
