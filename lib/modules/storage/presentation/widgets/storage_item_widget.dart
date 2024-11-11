import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

class StorageItemWidget extends StatelessWidget {
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
                    onPressed: () {},
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
                    onPressed: () {},
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
