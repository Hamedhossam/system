import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    required this.date,
    required this.orderId,
    super.key,
  });
  final String date;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Order id :", style: TextStyle(fontSize: 16)),
                Text(
                  "#$orderId",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const HorizentalLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Date :", style: TextStyle(fontSize: 16)),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const HorizentalLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Total Cost :", style: TextStyle(fontSize: 16)),
                Text(
                  "${BlocProvider.of<AddToCartCubit>(context).getTotalCost()} 💸",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
