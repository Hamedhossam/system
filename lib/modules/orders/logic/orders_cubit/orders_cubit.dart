import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';
part 'orders_cubit_state.dart';

class OrdersCubit extends Cubit<OrdersCubitState> {
  OrdersCubit() : super(OrdersCubitInitial());
  List<OrderModel> orders = [];
  List<ProductModel> allProducts = [];

  getAllOrders() async {
    orders.clear();
    emit(OrdersSearching());
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      var ordersBox = Hive.box<OrderModel>("orders_box");
      orders = ordersBox.values.toList();
      orders = orders.reversed.toList();
      if (orders.isEmpty) {
        emit(OrdersCubitEmpty());
      } else {
        emit(OrdersCubitSuccess(orders));
      }
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
  }

  getfilteredOrders(String query) async {
    orders.clear();
    emit(OrdersSearching());
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      var ordersBox = Hive.box<OrderModel>("orders_box");
      orders = ordersBox.values.toList();
      orders = orders.reversed.toList();
      orders = orders.where((element) => element.id.contains(query)).toList();
      if (orders.isEmpty) {
        emit(OrdersCubitEmpty());
      } else {
        emit(OrdersCubitSuccess(orders));
      }
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
  }

  void getTimePeriodOrders(String period) async {
    orders.clear();
    emit(OrdersSearching());
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      var ordersBox = Hive.box<OrderModel>("orders_box");
      orders = ordersBox.values.toList();
      orders = orders.reversed.toList();
      DateTime now = DateTime.now();

      if (period == "All") {
        // No change needed, orders already contains all orders
      } else if (period == "Today") {
        orders = orders.where((element) {
          DateTime orderDate = parseDateString(element.date);
          return orderDate.year == now.year &&
              orderDate.month == now.month &&
              orderDate.day == now.day;
        }).toList();
      } else if (period == "This Week") {
        orders = orders.where((element) {
          DateTime orderDate = parseDateString(element.date);
          return orderDate
                  .isAfter(now.subtract(Duration(days: now.weekday - 1))) &&
              orderDate
                  .isBefore(now.add(const Duration(days: 1))); // Include today
        }).toList();
      } else if (period == "This Month") {
        orders = orders.where((element) {
          DateTime orderDate = parseDateString(element.date);
          return orderDate.year == now.year && orderDate.month == now.month;
        }).toList();
      }
      // if (period == "All") {
      //   orders = orders;
      // } else if (period == "Today") {
      //   orders = orders
      //       .where((element) =>
      //           parseDateString(element.date).day == DateTime.now().day)
      //       .toList();
      // } else if (period == "This Week") {
      //   orders = orders
      //       .where((element) =>
      //           parseDateString(element.date).isAfter(DateTime.now().subtract(
      //             const Duration(days: 7),
      //           )))
      //       .toList();
      // } else if (period == "This Month") {
      //   orders = orders
      //       .where((element) =>
      //           parseDateString(element.date).month == DateTime.now().month)
      //       .toList();
      // }

      if (orders.isEmpty) {
        emit(OrdersCubitEmpty());
      } else {
        emit(OrdersCubitSuccess(orders));
      }
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
  }

  void returnOrder(OrderModel order) async {
    emit(OrdersSearching());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      allProducts = productsBox.values.toList();
      allProducts = allProducts.reversed.toList();
      for (var i = 0; i < allProducts.length; i++) {
        for (var j = 0; j < order.products.length; j++) {
          if (allProducts[i].name == getLastWord(order.products[j])) {
            allProducts[i].availablePieces = allProducts[i].availablePieces +
                int.parse(getFirstWord(order.products[j]));
            List<String> returnedList = List.generate(
              allProducts[i].numOfPiecesOrderd!,
              growable: true,
              (index) => '0',
            );
            allProducts[i].availableSizes!.addAll(returnedList);
            allProducts[i].numOfPiecesOrderd = 0;
            allProducts[i].save();
          }
        }
      }
      await order.delete();
      emit(OrdersCubitSuccess(orders));
    } on Exception catch (e) {
      emit(OrdersCubitFail());
      log(e.toString());
    }
  }

  DateTime parseDateString(String dateString) {
    // Define the date format
    final DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");
    return format.parse(dateString); // Parse the date string
  }

  String getLastWord(String input) {
    // Split the string by spaces and trim any extra whitespace
    List<String> words = input.trim().split(' ');
    // Return the last word if it exists
    return words.isNotEmpty ? words.last : '';
  }

  String getTotalCost(String id) {
    String cost = "";
    for (var i = 0; i < orders.length; i++) {
      if (orders[i].id == id) {
        cost = orders[i].price.toString();
        break;
      }
    }
    return cost;
  }

  String getFirstWord(String input) {
    // Split the string by spaces and trim any extra whitespace
    List<String> words = input.trim().split(' ');
    // Return the first word if it exists
    return words.isNotEmpty ? words.first : '';
  }
}
