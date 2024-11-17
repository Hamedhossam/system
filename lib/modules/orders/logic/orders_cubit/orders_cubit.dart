import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:motors/modules/orders/models/order_model.dart';

part 'orders_cubit_state.dart';

class OrdersCubit extends Cubit<OrdersCubitState> {
  OrdersCubit() : super(OrdersCubitInitial());
  //TODO THIS CUBIT WILL LOOK LIKE STORAGE PRODUCTS CUBIT SO LOOK THERE
  List<OrderModel> allOrders = [];
  List<OrderModel> todayOrders = [];
  List<OrderModel> yesterdayOrders = [];
  List<OrderModel> thisWeekOrders = [];

  getAllOrders() {
    todayOrders.clear();
    yesterdayOrders.clear();
    thisWeekOrders.clear();
    emit(OrdersCubitInitial());
    try {
      var ordersBox = Hive.box<OrderModel>("orders_box");
      allOrders = ordersBox.values.toList();
      // log(allOrders.length.toString());
      emit(OrdersCubitSuccess());
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
    for (var i = 0; i < allOrders.length; i++) {
      if (isToday(allOrders[i].date)) {
        todayOrders.add(allOrders[i]);
      } else if (isYesterday(allOrders[i].date)) {
        yesterdayOrders.add(allOrders[i]);
      } else if (isThisWeek(allOrders[i].date)) {
        thisWeekOrders.add(allOrders[i]);
      }
    }
  }

  bool isToday(String dateString) {
    DateTime orderDate = DateTime.parse(dateString);
    DateTime today = DateTime.now();
    return orderDate.year == today.year &&
        orderDate.month == today.month &&
        orderDate.day == today.day;
  }

  bool isYesterday(String dateString) {
    DateTime orderDate = DateTime.parse(dateString);
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    return orderDate.year == yesterday.year &&
        orderDate.month == yesterday.month &&
        orderDate.day == yesterday.day;
  }

  bool isThisWeek(String dateString) {
    DateTime orderDate = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateTime weekStart =
        now.subtract(Duration(days: now.weekday - 1)); // Start of the week
    return orderDate.isAfter(weekStart) &&
        orderDate.isBefore(now.add(const Duration(days: 1)));
  }
}
