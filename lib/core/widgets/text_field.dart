import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField({
    super.key,
    required this.tittle,
    required this.maxLines,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onSubmit,
  });
  final String tittle;
  final int maxLines;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmit;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        labelText: tittle,
        labelStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
      maxLines: maxLines,
    );
  }
}
