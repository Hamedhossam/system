part of 'shopping_products_cubit.dart';

@immutable
sealed class ShoppingProductsState {}

final class ShoppingProductsInitial extends ShoppingProductsState {}

final class ShoppingProductsLoading extends ShoppingProductsState {}

final class ShoppingProductsFailure extends ShoppingProductsState {}

final class ShoppingProductsSuccess extends ShoppingProductsState {
  // final List<ProductModel> products;

  // ShoppingProductsSuccess(this.products);
}
