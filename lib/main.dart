import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/adding_product_cubit/adding_product_cubit.dart';
import 'modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

void main() async {
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.initFlutter("D:/Programing/flutter/motors/storage");
  await Hive.openBox<ProductModel>("products_box");
  runApp(const SystemApp());
}

class SystemApp extends StatelessWidget {
  const SystemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StorageProductsCubit()),
        BlocProvider(create: (context) => AddingProductCubit()),
        BlocProvider(create: (context) => ShoppingProductsCubit()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(fontFamily: "NotoKufiArabic"),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Desktop Navigation',
        home: const HomeScreen(),
      ),
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
