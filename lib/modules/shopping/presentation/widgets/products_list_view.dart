import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
import 'package:motors/modules/shopping/presentation/logic/shopping_products_cubit/shopping_products_cubit.dart';
import 'package:motors/modules/shopping/presentation/widgets/shopping_product_widget.dart';

// ignore: must_be_immutable
class ProductsListView extends StatefulWidget {
  ProductsListView({
    required this.products,
    required this.category,
    required this.brand,
    super.key,
  });
  final List<ProductModel> products;
  String category;
  String brand;
  @override
  State<ProductsListView> createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<ShoppingProductsCubit>(context).getAllProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingProductsCubit, ShoppingProductsState>(
      builder: (context, state) {
        if (state is ShoppingProductsSuccess) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  childAspectRatio: 0.79, // Adjust to change item height/width
                ),
                itemCount: BlocProvider.of<ShoppingProductsCubit>(context)
                    .getProducts(widget.category, widget.brand)
                    .length,
                itemBuilder: (context, index) {
                  return ShoppingProductWidget(
                    productModel:
                        BlocProvider.of<ShoppingProductsCubit>(context)
                            .getProducts(widget.category, widget.brand)[index],
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
