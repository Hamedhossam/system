import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
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
          const HorizentalLine(),
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
          const HorizentalLine(),
          const Label(tittle: "Products"),
          const HorizentalLine(),
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const SizedBox(height: 5),
                      //! id Section
                      const Row(
                        children: [
                          SizedBox(width: 5),
                          SizedBox(
                            width: 230,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Id                  : (335478)",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      //! Availabe Sizes Section
                      const Row(
                        children: [
                          SizedBox(width: 5),
                          SizedBox(
                            width: 230,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Available Sizes : 36/37/38/39/40/41/42",
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
                            width: 115,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "Price              :",
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
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        onPressed: () {},
                        child: const Text(
                          'Add To Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
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
