import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';
import 'package:motors/modules/shopping/presentation/widgets/cart_items_list_view.dart';
import 'package:motors/modules/shopping/presentation/widgets/checkout_bottom_sheet.dart';
import 'package:motors/modules/shopping/presentation/widgets/order_details_widget.dart';
import 'package:motors/modules/shopping/presentation/widgets/shopping_cart_lable.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AddToCartCubit, AddToCartState>(
        builder: (context, state) {
          if (state is AddToCartInitial) {
            return const Center(child: ShoppingCartLabel());
          } else if (state is AddToCartSuccess) {
            return Column(
              children: [
                const ShoppingCartLabel(),
                const HorizentalLine(),
                const Row(children: [Label(tittle: "Order Details")]),
                OrderDetailsWidget(
                  date: state.date,
                  orderId: state.orderId,
                  totalCost: state.totalCost,
                ),
                const Row(children: [Label(tittle: "Items")]),
                const HorizentalLine(),
                CartItemsListView(products: state.products),
                const Spacer(
                  flex: 8,
                ),
                const HorizentalLine(),
                CustomizedButton(
                  tittle: "continue",
                  myColor: Colors.blue,
                  onTap: () {
                    showBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (context) {
                        return CheckOutBottomSheet(
                          tolalCost: state.totalCost,
                          orderId: state.orderId,
                          products: state.products,
                          date: state.date,
                        );
                      },
                    );
                  },
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
