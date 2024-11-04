import 'package:flutter/material.dart';

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
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    );
  }
}
