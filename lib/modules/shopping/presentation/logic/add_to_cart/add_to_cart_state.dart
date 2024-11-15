part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

final class AddToCartSuccess extends AddToCartState {
  List<ProductModel> products;
  String date;
  AddToCartSuccess({required this.products, required this.date});
}

final class AddToCartLoading extends AddToCartState {}
