import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:motors/core/screens/home_screen.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';

class AddToCartBottomSheet extends StatefulWidget {
  const AddToCartBottomSheet({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int productQuantity = 1;
  late int newAvailablePieces;
  String selectedDiscountMethod = "percentage";
  List<String> methods = ["percentage", "amount"];
  int discountAmount = 0;
  double discountPercentage = 0;
  bool isPercentage = true;
  TextEditingController discountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  double applyDiscount(double discountPercentage, double total) {
    return total - (total * (discountPercentage / 100));
  }

  @override
  void initState() {
    super.initState();
    newAvailablePieces = widget.productModel.availablePieces - 1;
    discountController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: SizedBox(
        height: 600.h,
        width: 500.w,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Row(
                        children: [
                          Text("Close"),
                          Icon(Icons.close),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  height: 180.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: FileImage(File(widget.productModel.imagePath)),
                  )),
                ),
                Text(
                  widget.productModel.name,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Price : ${widget.productModel.price} LE",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Pieces : ${newAvailablePieces.toString()}",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 165.w,
                      child: const HorizentalLine(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        underline: Container(
                          height: 2.h,
                          color: Colors.blueAccent, // Customize underline color
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.blueAccent), // Customize icon color
                        dropdownColor:
                            Colors.white, // Dropdown background color
                        value: selectedDiscountMethod,
                        hint: const Text('Discount'),
                        onChanged: (String? newValue) {
                          selectedDiscountMethod = newValue!;
                          (newValue == "amount")
                              ? isPercentage = false
                              : isPercentage = true;
                          setState(() {});
                        },
                        items: methods
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 165.w,
                      child: const HorizentalLine(),
                    )
                  ],
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 90.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 250.w,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomizedTextField(
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "enter discount";
                                } else {
                                  return null;
                                }
                              },
                              tittle:
                                  (isPercentage) ? "percet. %" : r"amount $",
                              maxLines: 1,
                              controller: discountController,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 5.w),
                      SizedBox(width: 5.w),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              discountPercentage =
                                  double.parse(discountController.text);
                              discountAmount =
                                  int.parse(discountController.text);
                            });
                          }
                        },
                        child: Text(
                          'Apply Discount',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const HorizentalLine(),
                SizedBox(
                  width: 500.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 35.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.only(top: 10),
                              iconSize: 17,
                              icon: const Icon(
                                Icons.maximize,
                                color: Colors.white,
                                size: 17,
                              ),
                              onPressed: () {
                                if (productQuantity == 1) {
                                  productQuantity = 1;
                                } else {
                                  productQuantity--;
                                  newAvailablePieces++;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          Text(
                            productQuantity.toString(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 35.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.only(bottom: 2),
                              iconSize: 17,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 17,
                              ),
                              onPressed: () {
                                if (productQuantity ==
                                    widget.productModel.availablePieces) {
                                  productQuantity =
                                      widget.productModel.availablePieces;
                                } else {
                                  productQuantity++;
                                  newAvailablePieces--;
                                }
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (isPercentage)
                                  ? "Total : ${applyDiscount(discountPercentage, (int.parse(widget.productModel.price) * productQuantity).toDouble())} LE"
                                  : "Total : ${((int.parse(widget.productModel.price) * productQuantity) - discountAmount).toString()} LE",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 60.h,
                  width: 200.w,
                  child: CustomizedButton(
                    tittle: "Add",
                    myColor: Colors.blue,
                    onTap: () {
                      var random = Random();
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd/MM/yyyy HH:mm a').format(now);
                      int orderId = 100000 +
                          random.nextInt(
                              900000); // Generates a number between 100000 an
                      widget.productModel.numOfPiecesOrderd = productQuantity;
                      widget.productModel.priceAfterDiscount = (isPercentage)
                          ? applyDiscount(
                                  discountPercentage,
                                  (int.parse(widget.productModel.price) *
                                          productQuantity)
                                      .toDouble())
                              .toString()
                          : ((int.parse(widget.productModel.price) *
                                      productQuantity) -
                                  discountAmount)
                              .toString();
                      if (isPercentage) {
                        widget.productModel.isPercentage = true;
                        widget.productModel.discountPercentage =
                            discountController.text;
                        widget.productModel.discountAmount = "0";
                      } else {
                        widget.productModel.discountAmount =
                            discountController.text;
                        widget.productModel.discountPercentage = "0";
                      }
                      BlocProvider.of<AddToCartCubit>(context).addProduct(
                        widget.productModel,
                        formattedDate,
                        orderId.toString(),
                        (isPercentage)
                            ? applyDiscount(
                                    discountPercentage,
                                    (int.parse(widget.productModel.price) *
                                            productQuantity)
                                        .toDouble())
                                .toString()
                            : ((int.parse(widget.productModel.price) *
                                        productQuantity) -
                                    discountAmount)
                                .toString(),
                      );
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
