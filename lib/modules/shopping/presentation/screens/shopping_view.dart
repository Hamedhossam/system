import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/presentation/widgets/category_widget.dart';

class ShoppingView extends StatelessWidget {
  const ShoppingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Label(tittle: "Categories"),
          const HorizentalDivider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryWidget(
                  tittle: 'Shoes (Men)', image: "assets/images/shoes_men.jpg"),
              CategoryWidget(
                  tittle: 'Shoes (Men)',
                  image: "assets/images/shoes_women.jpg"),
              CategoryWidget(
                  tittle: 'Shoes (Men)', image: "assets/images/bags.jpg"),
              CategoryWidget(
                  tittle: 'Shoes (Men)',
                  image: "assets/images/accessories.jpg"),
            ],
          ),
          const HorizentalDivider(),
          const Label(tittle: "Products"),
          const HorizentalDivider(),
          SizedBox(
            height: 430,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75, // Adjust to change item height/width
              ),
              itemCount: 17,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 235, 233, 233),
                  elevation: 4.0,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/superstar.jpg"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Addidas superstar mirror",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const SizedBox(height: 5),
                      //! Availabe Sizes Section
                      const Row(
                        children: [
                          SizedBox(width: 5),
                          SizedBox(
                            width: 230,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Available Sizes :  36/37/38/39/40/41/42",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      //! Price Section
                      const Row(
                        children: [
                          SizedBox(width: 5),
                          SizedBox(
                            width: 120,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Price              :  ",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "280 Le",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Placeholder for product image
                      ElevatedButton(
                        onPressed: () {
                          // Action for the button
                        },
                        child: const Text('Buy Now'),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class HorizentalDivider extends StatelessWidget {
  const HorizentalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Color.fromARGB(94, 0, 0, 0), // Line color
      thickness: 2, // Line thickness
      // Space from t),
    );
  }
}
