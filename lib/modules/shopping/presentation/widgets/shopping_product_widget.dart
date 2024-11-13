import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

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
            onPressed: () {},
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
}
