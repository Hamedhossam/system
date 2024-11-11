import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
part 'adding_product_state.dart';

class AddingProductCubit extends Cubit<AddingProductState> {
  AddingProductCubit() : super(AddingProductInitial());
  addProduct(ProductModel product) async {
    emit(AddingProductLoading());
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      await productsBox.add(product);
      emit(AddingProductSuccess());
      log("${product.name} has been added");
    } on Exception catch (e) {
      emit(AddingProductFailure());
      log(e.toString());
    }
  }
}
