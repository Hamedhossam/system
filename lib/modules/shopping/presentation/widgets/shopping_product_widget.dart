import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/widgets/add_to_cart_bottom_sheet.dart';

class ShoppingProductWidget extends StatelessWidget {
  const ShoppingProductWidget({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 235, 233, 233),
      elevation: 4.0,
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: FileImage(File(productModel.imagePath)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            productModel.name,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          SizedBox(height: 5.h),
          //! id Section
          Row(
            children: [
              SizedBox(width: 5.w),
              SizedBox(
                width: 250.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Id                  : (${productModel.id})",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ],
          ), //! Price Section
          Row(
            children: [
              SizedBox(width: 5.w),
              SizedBox(
                width: 150.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Price              :",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                "${productModel.price} LE",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          //! Availabe Sizes Section
          Row(
            children: [
              SizedBox(width: 5.w),
              SizedBox(
                width: 145.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Available Sizes : ",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 30.h,
                width: 140.w,
                child: ListView.builder(
                  itemCount: productModel.numAvailableSizes,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SizeBall(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      productModel.availableSizes == null
                          ? "(no sizes) "
                          : productModel.availableSizes![index],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () {
              _addToCart(context);
            },
            child: Text(
              'Add To Cart',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PersistentBottomSheetController _addToCart(BuildContext context) {
    return showBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return AddToCartBottomSheet(productModel: productModel);
        });
  }
}

class SizeBall extends StatelessWidget {
  const SizeBall({super.key, required this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.black,
        child: child,
      ),
    );
  }
}
