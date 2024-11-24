import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

part 'shopping_products_state.dart';

class ShoppingProductsCubit extends Cubit<ShoppingProductsState> {
  ShoppingProductsCubit() : super(ShoppingProductsInitial());
  List<ProductModel> allProducts = [];
  List<ProductModel> menProducts = [];
  List<ProductModel> womenProducts = [];
  List<ProductModel> bags = [];
  List<ProductModel> accessories = [];

  getAllProducts() {
    menProducts.clear();
    womenProducts.clear();
    bags.clear();
    accessories.clear();
    emit(ShoppingProductsLoading());
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      allProducts = productsBox.values.toList();
      log(allProducts.length.toString());
      emit(ShoppingProductsSuccess());
    } on Exception catch (e) {
      emit(ShoppingProductsFailure());
      log(e.toString());
    }
    for (var i = 0; i < allProducts.length; i++) {
      switch (allProducts[i].category) {
        case "Shoes(Men)":
          (allProducts[i].availablePieces >= 1)
              ? menProducts.add(allProducts[i])
              : null;
        case "Shoes(Women)":
          (allProducts[i].availablePieces >= 1)
              ? womenProducts.add(allProducts[i])
              : null;
        case "Bags":
          (allProducts[i].availablePieces >= 1)
              ? bags.add(allProducts[i])
              : null;
        case "Accessories":
          (allProducts[i].availablePieces >= 1)
              ? accessories.add(allProducts[i])
              : null;
        default:
      }
    }
  }

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

  List<ProductModel> getProducts(String category, String brand) {
    switch (category) {
      case "Shoes(Men)":
        // emit(ShoppingProductsSuccess(menProducts));
        // log(menProducts.last.brand!);
        // log(menProducts[2].brand!);
        return menProducts.where((product) => product.brand == brand).toList();
      case "Shoes(Women)":
        // emit(ShoppingProductsSuccess(womenProducts));
        return womenProducts
            .where((product) => product.brand == brand)
            .toList();
      case "Bags":
        // emit(ShoppingProductsSuccess(bags));
        return bags.where((product) => product.brand == brand).toList();
      case "Accessories":
        // emit(ShoppingProductsSuccess(accessories));
        log(accessories.length.toString());
        return accessories.where((product) => product.brand == brand).toList();
      default:
        return List.empty();
    }
  }
}
