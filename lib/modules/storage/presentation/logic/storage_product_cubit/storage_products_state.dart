part of 'storage_products_cubit.dart';

@immutable
sealed class StorageProductsState {}

final class StorageProductsInitial extends StorageProductsState {}

final class StorageProductsLoading extends StorageProductsState {}

final class StorageProductsFailure extends StorageProductsState {}

final class StorageProductsSuccess extends StorageProductsState {
  // final List<ProductModel> products;

  // StorageProductsSuccess(this.products);
}
