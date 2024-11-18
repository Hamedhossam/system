import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
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
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    const Text('⚠️ Do you want retrieval?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<OrdersCubit>(context)
                                          .retrieveOrder(orderModel, context);
                                      BlocProvider.of<OrdersCubit>(context)
                                          .getAllOrders();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                                backgroundColor:
                                    Colors.white, // Dark background color
                                // titleTextStyle: const TextStyle(color: Colors.white),
                                // contentTextStyle: const TextStyle(color: Colors.white),
                              );
                            },
                          );
                        },
                        child: const Icon(
                          Icons.replay_outlined,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // ElevatedButton(
                      //   style: const ButtonStyle(
                      //     backgroundColor: WidgetStatePropertyAll(Colors.red),
                      //   ),
                      //   onPressed: () {},
                      //   child: const Icon(
                      //     Icons.edit,
                      //     color: Colors.white,
                      //   ),
                      // ),
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
