import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/add_to_cart/add_to_cart_cubit.dart';

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
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: FileImage(File(productModel.imagePath)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            productModel.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 5),
          //! id Section
          Row(
            children: [
              const SizedBox(width: 5),
              SizedBox(
                width: 230,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Id                  : (${productModel.id})",
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          //! Availabe Sizes Section
          Row(
            children: [
              const SizedBox(width: 5),
              const SizedBox(
                width: 120,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Available Sizes : ",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(
                width: 90,
                height: 20,
                child: ListView.builder(
                  itemCount: productModel.numAvailableSizes,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Text(
                    overflow: TextOverflow.ellipsis,
                    productModel.availableSizes == null
                        ? "(no sizes) "
                        : "${productModel.availableSizes![index]} - ",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          //! Price Section
          Row(
            children: [
              const SizedBox(width: 5),
              const SizedBox(
                width: 115,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  "Price              :",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                productModel.price,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue)),
            onPressed: () {
              _addToCart(context);
            },
            child: const Text(
              'Add To Cart',
              style: TextStyle(
                fontSize: 16,
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
  @override
  void initState() {
    super.initState();
    newAvailablePieces = widget.productModel.availablePieces - 1;
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
        height: 420,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            CircleAvatar(
              backgroundImage: FileImage(File(widget.productModel.imagePath)),
              radius: 100,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              widget.productModel.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Price : ${widget.productModel.price} LE",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Pieces : ${newAvailablePieces.toString()}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 30,
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
                            "Total : ${(int.parse(widget.productModel.price) * productQuantity).toString()} LE",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
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
                  BlocProvider.of<AddToCartCubit>(context).addProduct(
                    widget.productModel,
                    formattedDate,
                    orderId.toString(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
