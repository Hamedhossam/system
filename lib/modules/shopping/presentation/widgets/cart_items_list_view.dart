import 'package:flutter/material.dart';
import 'package:motors/modules/shopping/presentation/widgets/cart_item.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return const CartItemWidget();
        },
      ),
    );
  }
}
