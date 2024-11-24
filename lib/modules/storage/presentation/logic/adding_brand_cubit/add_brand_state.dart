part of 'add_brand_cubit.dart';

@immutable
sealed class AddBrandState {}

final class AddBrandInitial extends AddBrandState {}

final class AddBrandSuccess extends AddBrandState {}

final class AddBrandFail extends AddBrandState {}
