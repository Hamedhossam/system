import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/label.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/shopping/presentation/widgets/category_widget.dart';
import 'package:motors/modules/shopping/presentation/widgets/products_list_view.dart';
import 'package:motors/modules/storage/presentation/logic/adding_brand_cubit/add_brand_cubit.dart';
import 'package:motors/modules/storage/presentation/logic/storage_product_cubit/storage_products_cubit.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  String category = "Shoes(Men)";
  List<String> brands = [];
  int selectedBrand = 0;
  String selectedBrandName = 'Addidas';
  late List<ProductModel> products;
  String getFirstWord(String input) {
    // Split the string by spaces
    List<String> words = input.split(' ');

    // Check if the list has at least one word
    if (words.isNotEmpty) {
      return words[0]; // Return the first word
    } else {
      return ''; // Return an empty string if no words are found
    }
  }

  String getSecondWord(String input) {
    // Split the string by spaces
    List<String> words = input.split(' ');

    // Check if the list has at least one word
    if (words.isNotEmpty) {
      return words[1]; // Return the first word
    } else {
      return ''; // Return an empty string if no words are found
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddBrandCubit>(context).getBrands();
    BlocProvider.of<StorageProductsCubit>(context).getAllProducts();
    BlocProvider.of<ShoppingProductsCubit>(context).getAllProducts();
    products = BlocProvider.of<ShoppingProductsCubit>(context)
        .getProducts(category, selectedBrandName);
    brands = BlocProvider.of<AddBrandCubit>(context).menBrands;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Label(tittle: "Shopping"),
          const HorizentalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CategoryWidget(
                    image: "assets/images/shoes_men.jpg",
                    onTap: () {
                      category = "Shoes(Men)";
                      brands =
                          BlocProvider.of<AddBrandCubit>(context).menBrands;

                      setState(() {});
                    },
                    tittle: 'Shoes(Men)',
                  ),
                ],
              ),
              CategoryWidget(
                image: "assets/images/shoes_women.jpg",
                onTap: () {
                  category = "Shoes(Women)";
                  brands = BlocProvider.of<AddBrandCubit>(context).womenBrands;
                  setState(() {});
                },
                tittle: "Shoes(Women)",
              ),
              CategoryWidget(
                image: "assets/images/bags.jpg",
                onTap: () {
                  category = "Bags";
                  brands = BlocProvider.of<AddBrandCubit>(context).bagsBrands;
                  setState(() {});
                },
                tittle: "Bags",
              ),
              CategoryWidget(
                image: "assets/images/accessories2.jpg",
                onTap: () {
                  category = "Accessories";
                  brands =
                      BlocProvider.of<AddBrandCubit>(context).accessoriesBrands;
                  setState(() {});
                },
                tittle: "Accessories",
              ),
            ],
          ),
          const HorizentalLine(),
          const Label(tittle: "Products"),
          const HorizentalLine(),
          SizedBox(
            height: 80.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    selectedBrand = index;
                    selectedBrandName = getFirstWord(brands[index]);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: selectedBrand == index
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35.h,
                            backgroundImage:
                                FileImage(File(getSecondWord(brands[index]))),
                          ),
                          Text(
                            getFirstWord(brands[index]),
                            style: TextStyle(
                                color: selectedBrand == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ProductsListView(
            products: products,
            category: category,
            brand: getFirstWord(selectedBrandName),
          )
        ],
      ),
    );
  }
}
