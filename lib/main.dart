import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/modules/orders/logic/add_order_cubit/add_order_cubit.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/adding_brand_cubit/add_brand_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/adding_product_cubit/adding_product_cubit.dart';
import 'modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

void main() async {
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  await Hive.initFlutter("D:/Programing/flutter/motors/storage");
  await Hive.openBox<ProductModel>("products_box");
  await Hive.openBox<OrderModel>("orders_box");
  await Hive.openBox<String>("brands_box");
  runApp(
    ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const SystemApp();
      },
    ),
  );
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
        BlocProvider(create: (context) => AddToCartCubit()),
        BlocProvider(create: (context) => AddOrderCubit()),
        BlocProvider(create: (context) => OrdersCubit()),
        BlocProvider(create: (context) => AddBrandCubit()),
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
