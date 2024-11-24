import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/widgets/cart_item.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({
    required this.products,
    super.key,
  });
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550.h,
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return CartItemWidget(
            productModel: products[index],
          );
        },
      ),
    );
  }
}
