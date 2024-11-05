import 'package:flutter/material.dart';
import 'package:motors/core/widgets/buisiness_image.dart';
import 'package:motors/core/widgets/exit_widget.dart';
import 'package:motors/core/widgets/vertical_line.dart';
import 'package:motors/modules/shopping/presentation/widgets/shopping_screen_body.dart';
import 'package:motors/modules/storage/presentation/screens/storage_screen.dart';
import 'package:motors/modules/orders/presentation/screens/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // bool _isExtended = false;

  final List<Widget> _pages = const [
    ShoppingScreenBody(),
    StorageScreen(),
    OrdersScreen(),
  ];
  List<NavigationRailDestination> navigationDestinations = [
    NavigationRailDestination(
      selectedIcon: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: Image.asset("assets/icons/cashier.png")),
      ),
      icon: Container(
        width: 65,
        height: 65,
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
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/storage.png")),
        ),
      ),
      icon: Container(
        width: 65,
        height: 65,
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
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Center(child: Image.asset("assets/icons/orders.png")),
        ),
      ),
      icon: Container(
        width: 65,
        height: 65,
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
              leading: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        size: 40,
                      ),
                      onPressed: () {
                        // setState(() {
                        //   _isExtended = !_isExtended;
                        // });
                      },
                    ),
                    const BuisinessImage(),
                  ],
                ),
              ),
              trailing: const ExitWidget(),
              minExtendedWidth: 40,
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
