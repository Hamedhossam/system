import 'package:flutter/material.dart';
import 'package:motors/screens/shopping_screen.dart';
import 'package:motors/views/products_manager_view.dart';
import 'package:motors/views/setting_view.dart';
import 'package:motors/widgets/buisiness_image.dart';
import 'package:motors/widgets/exit_widget.dart';
import 'package:motors/widgets/vertical_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isExtended = false;

  final List<Widget> _pages = const [
    ShoppingScreen(),
    ProductsManagerView(),
    SettingView(),
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
              extended: _isExtended,
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
