part of 'storage_products_cubit.dart';

@immutable
sealed class StorageProductsState {}

final class StorageProductsInitial extends StorageProductsState {}

final class StorageProductsFailure extends StorageProductsState {}

final class StorageProductsSuccess extends StorageProductsState {}
