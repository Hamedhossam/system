import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  List<ProductModel> products = [];
  String date = "";
  String id = "";
  String totalCost = "";

  addProduct(ProductModel product, String dateTime, String orderId) async {
    date = dateTime;
    id = orderId;
    if (products.isEmpty) {
      emit(AddToCartInitial());
    }
    bool exist = await isExist(products, product);
    if (exist) {
      emit(AddToCartSuccess(products: products, date: date, orderId: id));
    } else {
      products.add(product);
      emit(AddToCartLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AddToCartSuccess(products: products, date: date, orderId: id));
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
    emit(AddToCartSuccess(products: products, date: date, orderId: id));
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
    int totalCost = 0;
    for (var i = 0; i < products.length; i++) {
      totalCost = totalCost +
          (int.parse(products[i].price) * products[i].numOfPiecesOrderd!);
    }
    return totalCost.toString();
  }
}
