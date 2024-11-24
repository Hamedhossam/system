import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  List<ProductModel> products = [];
  String date = "";
  String id = "";

  addProduct(ProductModel product, String dateTime, String orderId,
      String cost) async {
    date = dateTime;
    id = orderId;
    String totalCost = "0";
    bool exist = await isExist(products, product);
    if (exist) {
      totalCost = (double.parse(totalCost) + double.parse(cost)).toString();
    } else {
      totalCost = (double.parse(totalCost) + double.parse(cost)).toString();
    }
    if (products.isEmpty) {
      emit(AddToCartInitial());
    }
    if (exist) {
      emit(AddToCartSuccess(
        products: products,
        date: date,
        orderId: id,
        totalCost: totalCost,
      ));
    } else {
      products.add(product);
      emit(AddToCartLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AddToCartSuccess(
        products: products,
        date: date,
        orderId: id,
        totalCost: totalCost,
      ));
    }
  }

  deleteProduct(ProductModel product) async {
    emit(AddToCartLoading());
    await Future.delayed(const Duration(seconds: 1));
    for (var i = 0; i < products.length; i++) {
      // if (product.id == products[i].id) {
      //   products.remove(product);
      // }
      products.remove(product);
    }
    if (products.isEmpty) {
      emit(AddToCartInitial());
    } else {
      emit(AddToCartSuccess(
        products: products,
        date: date,
        orderId: id,
        totalCost: "0",
      ));
    }
  }

  Future<bool> isExist(
      List<ProductModel> products, ProductModel product) async {
    bool exist = false;
    for (var i = 0; i < products.length; i++) {
      if (product.name == products[i].name) {
        // int oldQuantity = products[i].numOfPiecesOrderd!;
        // product.numOfPiecesOrderd = product.numOfPiecesOrderd! + oldQuantity;
        exist = true;
      }
    }
    return exist;
  }

  String getTotalCost() {
    double totalCost = 0;
    for (var i = 0; i < products.length; i++) {
      totalCost = totalCost + double.parse(products[i].priceAfterDiscount);
    }
    return totalCost.toString();
  }

  clearProducts() {
    products.clear();
    emit(AddToCartInitial());
  }
}
