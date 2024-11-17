import 'package:flutter/material.dart';
import 'package:motors/modules/orders/models/order_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    required this.orderModel,
    super.key,
  });
  final OrderModel orderModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "#Products",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 160,
                    width: 200,
                    child: ListView.builder(
                      itemCount: orderModel.products.length,
                      itemBuilder: (context, index) {
                        return Text(
                          overflow: TextOverflow.ellipsis,
                          orderModel.products[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromARGB(255, 92, 91, 91)),
                        );
                      },
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "#Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.qr_code),
                      ),
                      Text(
                        orderModel.id,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 91, 91)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.person),
                      ),
                      Text(
                        orderModel.clientName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 91, 91)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.phone_android),
                      ),
                      Text(
                        orderModel.clientPhone,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 91, 91)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.date_range),
                      ),
                      Text(
                        orderModel.date,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 91, 91)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5.0),
                        child: Icon(Icons.attach_money),
                      ),
                      Text(
                        "${orderModel.price.toString()} LE",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 92, 91, 91)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                        ),
                        onPressed: () {},
                        child: const Icon(
                          Icons.replay_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
