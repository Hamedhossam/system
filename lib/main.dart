import 'package:flutter/material.dart';
import 'package:motors/core/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "NotoKufiArabic"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Desktop Navigation',
      home: const HomeScreen(),
    );
  }
}
