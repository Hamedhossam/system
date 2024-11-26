import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

class StorageItemWidget extends StatelessWidget {
  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('⚠️ Do you want to delete?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                productModel.delete();
                BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
          backgroundColor: Colors.white, // Dark background color
          // titleTextStyle: const TextStyle(color: Colors.white),
          // contentTextStyle: const TextStyle(color: Colors.white),
        );
      },
    );
  }

  PersistentBottomSheetController _editProduct(BuildContext context) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 400.h,
            width: 300.w,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productModel.numAvailableSizes,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (value) =>
                              productModel.availableSizes![index] = value,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly, // Only allow digits
                          ],
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            labelText: "size ${index + 1}",
                            labelStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          maxLines: 1,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  const StorageItemWidget({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: (productModel.availablePieces <= 1)
                    ? Colors.red
                    : Colors.green,
                width: 2.w),
            borderRadius: BorderRadius.circular(10)),
        child: Card(
          color: const Color.fromARGB(255, 235, 233, 233),
          elevation: 4.0,
          child: Column(
            children: [
              Container(
                height: 200.h,
                width: 300.w,
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
                  fontSize: 14.sp,
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
                    width: 230.w,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Id                  : (${productModel.id})",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              //! Availabe Sizes Section
              Row(
                children: [
                  SizedBox(width: 5.w),
                  (productModel.availablePieces < 1)
                      ? SizedBox(
                          width: 230.w,
                          child: Center(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              "( SOLD OUT ! )",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 230.w,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Available Pices : ${productModel.availablePieces.toString()}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                ],
              ),
              //! Price Section
              Row(children: [
                SizedBox(
                  width: 230.w,
                  child: Row(
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Price               : ",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "${productModel.price} LE",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(height: 10.h),
              Row(
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      _editProduct(context);
                    },
                    child: Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    child: Text(
                      'delete',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
