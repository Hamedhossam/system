import 'package:flutter/material.dart';

class HorizentalLine extends StatelessWidget {
  const HorizentalLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromARGB(94, 0, 0, 0), // Line color
      thickness: 2, // Line thickness
      // Space from t),
    );
  }
}
