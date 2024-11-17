import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:motors/modules/orders/models/order_model.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit() : super(AddOrderInitial());
  addOrder(OrderModel order) async {
    emit(AddOrderLoading());
    try {
      var ordersBox = Hive.box<OrderModel>("orders_box");
      ordersBox.add(order);
      log(order.products.last);
      emit(AddOrderSuccess());
    } on Exception catch (e) {
      emit(AddOrderFailure());
      log(e.toString());
    }
  }
}
