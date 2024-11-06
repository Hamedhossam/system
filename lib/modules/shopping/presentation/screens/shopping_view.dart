import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/presentation/widgets/category_widget.dart';
import 'package:motors/modules/shopping/presentation/widgets/products_list_view.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Label(tittle: "Categories"),
          HorizentalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryWidget(
                  tittle: 'Shoes(Men)', image: "assets/images/shoes_men.jpg"),
              CategoryWidget(
                  tittle: 'Shoes(Women)',
                  image: "assets/images/shoes_women.jpg"),
              CategoryWidget(tittle: 'Bags', image: "assets/images/bags.jpg"),
              CategoryWidget(
                  tittle: 'Accessories',
                  image: "assets/images/accessories2.jpg"),
            ],
          ),
          HorizentalLine(),
          Label(tittle: "Products"),
          HorizentalLine(),
          ProductsListView()
        ],
      ),
    );
  }
}
