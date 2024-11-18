part of 'orders_cubit.dart';

@immutable
sealed class OrdersCubitState {}

final class OrdersCubitInitial extends OrdersCubitState {}

final class OrdersCubitSuccess extends OrdersCubitState {}

final class OrdersCubitFail extends OrdersCubitState {}

final class OrdersCubitEmpty extends OrdersCubitState {}

final class OrdersSearching extends OrdersCubitState {}
