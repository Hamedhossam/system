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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const ShoppingCartLabel(),
          const HorizentalLine(),
          const Row(children: [Label(tittle: "Order Details")]),
          const OrderDetailsWidget(),
          const Row(children: [Label(tittle: "Items")]),
          const HorizentalLine(),
          const CartItemsListView(),
          const HorizentalLine(),
          CustomizedButton(
              tittle: "continue",
              myColor: Colors.blue,
              onTap: () {
                showBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: 500,
                        height: 500,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                      );
                    });
              })
        ],
      ),
    );
  }
}
