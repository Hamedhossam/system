import 'package:flutter/material.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/presentation/widgets/cart_items_list_view.dart';
import 'package:motors/modules/shopping/presentation/widgets/order_details_widget.dart';
import 'package:motors/modules/shopping/presentation/widgets/shopping_cart_lable.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ShoppingCartLabel(),
          HorizentalLine(),
          Row(children: [Label(tittle: "Order Details")]),
          OrderDetailsWidget(),
          Row(children: [Label(tittle: "Items")]),
          HorizentalLine(),
          CartItemsListView(),
          HorizentalLine(),
          CustomizedButton(tittle: "continue", myColor: Colors.blue)
        ],
      ),
    );
  }
}
