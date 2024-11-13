import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/presentation/widgets/category_widget.dart';
import 'package:motors/modules/shopping/presentation/widgets/products_list_view.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  String category = "Shoes(Men)";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Label(tittle: "Categories"),
          const HorizentalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const CategoryWidget(image: "assets/images/shoes_men.jpg"),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      category = "Shoes(Men)";
                      setState(() {});
                    },
                    icon: const Text(
                      "Shoes(Men)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const CategoryWidget(image: "assets/images/shoes_women.jpg"),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      category = "Shoes(Women)";
                      setState(() {});
                    },
                    icon: const Text(
                      "Shoes(Women)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const CategoryWidget(image: "assets/images/bags.jpg"),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      category = "Bags";
                      setState(() {});
                    },
                    icon: const Text(
                      "Bags",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const CategoryWidget(image: "assets/images/accessories2.jpg"),
                  IconButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      category = "Accessories";
                      setState(() {});
                    },
                    icon: const Text(
                      "Accessories",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const HorizentalLine(),
          const Label(tittle: "Products"),
          const HorizentalLine(),
          ProductsListView(category: category)
        ],
      ),
    );
  }
}
