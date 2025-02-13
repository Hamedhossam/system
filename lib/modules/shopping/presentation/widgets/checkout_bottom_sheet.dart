import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/orders/logic/add_order_cubit/add_order_cubit.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/shopping/presentation/widgets/printing_screen.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

class CheckOutBottomSheet extends StatelessWidget {
  CheckOutBottomSheet({
    required this.orderId,
    required this.products,
    required this.date,
    required this.tolalCost,
    super.key,
  });
  final String orderId;
  final String tolalCost;
  final String date;
  final List<ProductModel> products;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3.w),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      height: 420.h,
      width: 300.w,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              "--> $orderId <--",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomizedTextField(
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please fill the fields';
                }
                return null; // Return null
              },
              tittle: "Client Name",
              maxLines: 1,
              controller: _nameController,
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomizedTextField(
              validator: (p0) {
                if (p0 == null || p0.isEmpty) {
                  return 'Please fill the fields';
                }
                // Check if the input has exactly 11 digits
                if (p0.length != 11 || !RegExp(r'^\d{11}$').hasMatch(p0)) {
                  return 'Must be exactly 11 number';
                }
                return null; // Return null if the input is valid
              },
              tittle: "Phone",
              maxLines: 1,
              controller: _phoneController,
            ),
            SizedBox(
              height: 8.h,
            ),
            SizedBox(
              height: 135.h,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Text(
                    "${products[index].numOfPiecesOrderd.toString()} X ${products[index].name}",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: CustomizedButton(
                tittle: "Print",
                myColor: Colors.blue,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<StorageProductsCubit>(context)
                        .deductTheNumberOfPiecesOfProducts(products);
                    BlocProvider.of<StorageProductsCubit>(context)
                        .getAllProducts();
                    BlocProvider.of<ShoppingProductsCubit>(context)
                        .getAllProducts();
                    List<String> productsDetails = [];
                    for (var i = 0; i < products.length; i++) {
                      productsDetails.add(
                          "${products[i].numOfPiecesOrderd.toString()} X ${products[i].name}");
                    }
                    BlocProvider.of<AddOrderCubit>(context).addOrder(
                      OrderModel(
                        id: orderId,
                        clientName: _nameController.text,
                        date: date,
                        price: double.parse(
                            BlocProvider.of<AddToCartCubit>(context)
                                .getTotalCost()),
                        clientPhone: _phoneController.text,
                        products: productsDetails,
                      ),
                    );
                    BlocProvider.of<AddToCartCubit>(context).clearProducts();
                    BlocProvider.of<OrdersCubit>(context).getAllOrders();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PillScreen(
                            orderModel: OrderModel(
                              id: orderId,
                              clientName: _nameController.text,
                              date: date,
                              price: double.parse(
                                  BlocProvider.of<OrdersCubit>(context)
                                      .getLastOrderPrice()),
                              clientPhone: _phoneController.text,
                              products: productsDetails,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
