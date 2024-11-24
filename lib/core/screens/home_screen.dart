import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/buisiness_image.dart';
import 'package:motors/core/widgets/exit_widget.dart';
import 'package:motors/core/widgets/vertical_line.dart';
import 'package:motors/modules/shopping/presentation/widgets/shopping_screen_body.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';
import 'package:motors/modules/storage/presentation/screens/storage_screen.dart';
import 'package:motors/modules/orders/presentation/screens/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // bool _isExtended = false;

  final List<Widget> _pages = [
    const ShoppingScreenBody(),
    const StorageScreen(),
    const OrdersScreen(),
  ];
  List<NavigationRailDestination> navigationDestinations = [
    NavigationRailDestination(
      selectedIcon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Image.asset("assets/icons/cashier.png")),
      ),
      icon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(182, 194, 192, 192),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/cashier.png")),
        ),
      ),
      label: const Text("Shop      "),
    ),
    NavigationRailDestination(
      selectedIcon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/storage.png")),
        ),
      ),
      icon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(182, 194, 192, 192),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/storage.png")),
        ),
      ),
      label: const Text("Products "),
    ),
    NavigationRailDestination(
      selectedIcon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/orders.png")),
        ),
      ),
      icon: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: const Color.fromARGB(182, 194, 192, 192),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/orders.png")),
        ),
      ),
      label: const Text("Manage  "),
    ),
  ];
  void _onItemTapped(int index) {
    if (index == 1) {
      BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavigationRail(
              leading: const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    BuisinessImage(),

                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.menu_rounded,
                    //     size: 40,
                    //   ),
                    //   onPressed: () {
                    //     // setState(() {
                    //     //   _isExtended = !_isExtended;
                    //     // });
                    //   },
                    // ),
                    // const BuisinessImage(),
                  ],
                ),
              ),
              trailing: const ExitWidget(),
              minExtendedWidth: 40.w,
              backgroundColor: Colors.white,
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
              indicatorColor: Colors.transparent,
              // extended: _isExtended,
              destinations: navigationDestinations),
          const CustomizedVerticalLine(),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
