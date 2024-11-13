import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            height: 400,
            width: 300,
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
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            labelText: "size ${index + 1}",
                            labelStyle: const TextStyle(
                              fontSize: 20,
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
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Card(
          color: const Color.fromARGB(255, 235, 233, 233),
          elevation: 4.0,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 300,
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
                  SizedBox(
                    width: 230,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Available Pices : ${productModel.availablePieces.toString()}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              //! Price Section
              Row(children: [
                SizedBox(
                  width: 230,
                  child: Row(
                    children: [
                      const Text(
                        overflow: TextOverflow.ellipsis,
                        "Price               : ",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        productModel.price,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: () {
                      _editProduct(context);
                    },
                    child: const Text(
                      'edit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    child: const Text(
                      'delete',
                      style: TextStyle(
                        fontSize: 16,
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
