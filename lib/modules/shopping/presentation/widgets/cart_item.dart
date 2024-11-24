import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({
    required this.productModel,
    super.key,
  });
  final ProductModel productModel;
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
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      FileImage(File(widget.productModel.imagePath)),
                ),
                const Spacer(
                  flex: 30,
                ),
                Column(
                  children: [
                    Text(
                      widget.productModel.name,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.productModel.id,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   "(32)",
                    //   style: TextStyle(
                    //     fontSize: 14.sp,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(
                  flex: 50,
                ),
                IconButton(
                  color: Colors.red,
                  onPressed: () {
                    BlocProvider.of<AddToCartCubit>(context)
                        .deleteProduct(widget.productModel);
                  },
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
            SizedBox(height: 10.h),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.productModel.numOfPiecesOrderd.toString()} X",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "${widget.productModel.price} = ${(int.parse(widget.productModel.price) * widget.productModel.numOfPiecesOrderd!).toString()} LE",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 220.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (widget.productModel.isPercentage)
                          ? "(Discount : ${widget.productModel.discountPercentage} %)"
                          : "(Discount : ${widget.productModel.discountAmount} LE)",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
