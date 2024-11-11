import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

void main() async {
  await Hive.initFlutter("D:/Programing/flutter/motors/storage");
  await Hive.openBox<ProductModel>("products_box");
  Hive.registerAdapter(ProductModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(fontFamily: "NotoKufiArabic"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Desktop Navigation',
      home: const HomeScreen(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
