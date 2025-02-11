part of 'add_to_cart_cubit.dart';

@immutable
sealed class AddToCartState {}

final class AddToCartInitial extends AddToCartState {}

// ignore: must_be_immutable
final class AddToCartSuccess extends AddToCartState {
  List<ProductModel> products;
  String date;
  String orderId;
  String totalCost;
  AddToCartSuccess(
      {required this.products,
      required this.date,
      required this.orderId,
      required this.totalCost});
}

final class AddToCartLoading extends AddToCartState {}
