import 'package:flutter/material.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/orders/presentation/widgets/order_widget.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({
    super.key,
    required this.orders,
  });
  final List<OrderModel> orders;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 210,
          width: 1450,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderWidget(orderModel: orders[index]);
            },
          ),
        ),
      ],
    );
  }
}
