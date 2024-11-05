import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    super.key,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int productQuantity = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 205, 204, 204)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(
                  flex: 5,
                ),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/superstar.jpg"),
                ),
                const Spacer(
                  flex: 30,
                ),
                const Column(
                  children: [
                    Text(
                      "Addidas superstar mirror",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "#123546",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(32)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 50,
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever, size: 30,
                    // color: Colors.white,
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.only(top: 10),
                            iconSize: 17,
                            icon: const Icon(
                              Icons.maximize,
                              color: Colors.white,
                              size: 17,
                            ),
                            onPressed: () {
                              (productQuantity == 0)
                                  ? productQuantity = 0
                                  : productQuantity--;
                              setState(() {});
                            },
                          ),
                        ),
                        Text(
                          productQuantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.only(bottom: 2),
                            iconSize: 17,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 17,
                            ),
                            onPressed: () {
                              productQuantity++;
                              setState(() {});
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "120 L.E",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
