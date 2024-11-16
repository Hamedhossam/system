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

  List<ProductModel> getProducts(String category) {
    switch (category) {
      case "Shoes(Men)":
        // emit(ShoppingProductsSuccess(menProducts));
        return menProducts;
      case "Shoes(Women)":
        // emit(ShoppingProductsSuccess(womenProducts));
        return womenProducts;
      case "Bags":
        // emit(ShoppingProductsSuccess(bags));
        return bags;
      case "Accessories":
        // emit(ShoppingProductsSuccess(accessories));
        log(accessories.length.toString());
        return accessories;
      default:
        return List.empty();
    }
  }
}
