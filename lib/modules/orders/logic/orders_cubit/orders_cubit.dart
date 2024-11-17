import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:motors/modules/orders/models/order_model.dart';

part 'orders_cubit_state.dart';

class OrdersCubit extends Cubit<OrdersCubitState> {
  OrdersCubit() : super(OrdersCubitInitial());
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
      allOrders = allOrders.reversed.toList();
      // log(allOrders.length.toString());
      emit(OrdersCubitSuccess());
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));

    for (var order in allOrders) {
      DateTime orderDate = parseDateString(order.date);

      // Check for today
      if (orderDate.year == today.year &&
          orderDate.month == today.month &&
          orderDate.day == today.day) {
        todayOrders.add(order);
      }
      // Check for yesterday
      else if (orderDate.year == yesterday.year &&
          orderDate.month == yesterday.month &&
          orderDate.day == yesterday.day) {
        yesterdayOrders.add(order);
      }
      // Check for this week
      else if (orderDate.isAfter(weekStart) &&
          orderDate.isBefore(today.add(const Duration(days: 1)))) {
        thisWeekOrders.add(order);
      }

      // for (var i = allOrders.length - 1; i >= 0; i--) {
      //   if (isToday(allOrders[i].date)) {
      //     todayOrders.add(allOrders[i]);
      //   } else if (isYesterday(allOrders[i].date)) {
      //     yesterdayOrders.add(allOrders[i]);
      //   } else if (isThisWeek(allOrders[i].date)) {
      //     thisWeekOrders.add(allOrders[i]);
      //   }
    }
  }

  DateTime parseDateString(String dateString) {
    // Define the date format
    final DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");
    return format.parse(dateString); // Parse the date string
  }

  bool isToday(String dateString) {
    DateTime orderDate = parseDateString(dateString);
    DateTime today = DateTime.now();
    return orderDate.year == today.year &&
        orderDate.month == today.month &&
        orderDate.day == today.day;
  }

  bool isYesterday(String dateString) {
    DateTime orderDate = parseDateString(dateString);
    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    return orderDate.year == yesterday.year &&
        orderDate.month == yesterday.month &&
        orderDate.day == yesterday.day;
  }

  bool isThisWeek(String dateString) {
    DateTime orderDate = parseDateString(dateString);
    DateTime now = DateTime.now();
    DateTime weekStart =
        now.subtract(Duration(days: now.weekday - 1)); // Start of the week
    return orderDate.isAfter(weekStart) &&
        orderDate.isBefore(
          now.add(
            const Duration(days: 1),
          ),
        );
  }
}
