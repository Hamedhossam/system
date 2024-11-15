import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  List<ProductModel> products = [];
  String date = "";
  addProduct(ProductModel product, String dateTime) async {
    date = dateTime;
    if (products.isEmpty) {
      emit(AddToCartInitial());
    }
    products.add(product);
    emit(AddToCartLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(AddToCartSuccess(products: products, date: date));
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
    emit(AddToCartSuccess(products: products, date: date));
  }
}
