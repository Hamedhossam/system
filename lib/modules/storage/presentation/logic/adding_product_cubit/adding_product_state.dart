part of 'adding_product_cubit.dart';

@immutable
sealed class AddingProductState {}

final class AddingProductInitial extends AddingProductState {}

final class AddingProductLoading extends AddingProductState {}

final class AddingProductSuccess extends AddingProductState {}

final class AddingProductFailure extends AddingProductState {}
