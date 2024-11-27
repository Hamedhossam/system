import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_label.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_list_view.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_screen_tittle.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderModel> todayOrders = [];
  List<OrderModel> allOrders = [];
  List<OrderModel> thisWeekOrders = [];
  List<OrderModel> thisMonthOrders = [];
  List<String> ordersCategories = ["All", "Today", "This Week", "This Month"];
  String selectedOrderCategory = "All";
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersCubit>(context).getAllOrders();
    todayOrders = BlocProvider.of<OrdersCubit>(context).todayOrders;
    allOrders = BlocProvider.of<OrdersCubit>(context).allOrders;
    thisWeekOrders = BlocProvider.of<OrdersCubit>(context).thisWeekOrders;
    thisMonthOrders = BlocProvider.of<OrdersCubit>(context).thisMonthOrders;

    // yesterdayOrders = BlocProvider.of<OrdersCubit>(context).yesterdayOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const OrdersScreenTittle(),
          const HorizentalLine(),
          DropdownButton<String>(
            focusColor: Colors.white,
            underline: Container(
              height: 2.h,
              color: Colors.blueAccent, // Customize underline color
            ),
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
            icon: const Icon(Icons.arrow_drop_down,
                color: Colors.blueAccent), // Customize icon color
            dropdownColor: Colors.white, // Dropdown background color
            value: selectedOrderCategory,
            hint: const Text('Select Time'),
            onChanged: (String? newValue) {
              setState(() {
                selectedOrderCategory = newValue!;
                BlocProvider.of<OrdersCubit>(context).getAllOrders();
                // if (selectedOrderCategory == "All") {
                //   allOrders = allOrders;
                // } else if (selectedOrderCategory == "Today") {
                //   allOrders = todayOrders;
                // } else if (selectedOrderCategory == "This Week") {
                //   allOrders = thisWeekOrders;
                // } else if (selectedOrderCategory == "This Month") {
                //   allOrders = thisMonthOrders;
                // }
              });
            },
            items:
                ordersCategories.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
                ),
              );
            }).toList(),
          ),

          OrdersLabel(tittle: selectedOrderCategory),
          BlocBuilder<OrdersCubit, OrdersCubitState>(
            builder: (context, state) {
              if (state is OrdersCubitSuccess) {
                if ((selectedOrderCategory == "Today")) {
                  return OrdersListView(
                      orders:
                          BlocProvider.of<OrdersCubit>(context).todayOrders);
                } else if ((selectedOrderCategory == "This Week")) {
                  return OrdersListView(
                      orders:
                          BlocProvider.of<OrdersCubit>(context).thisWeekOrders);
                } else if ((selectedOrderCategory == "This Month")) {
                  return OrdersListView(
                      orders: BlocProvider.of<OrdersCubit>(context)
                          .thisMonthOrders);
                } else {
                  return OrdersListView(
                      orders: BlocProvider.of<OrdersCubit>(context).allOrders);
                }
              } else {
                return Center(
                  child: Text(
                    "There is no Orders at This Time",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                );
              }
            },
          ),

         
        ],
      ),
    );
  }
}
/* /*
          OrdersListView(
                orders: (selectedOrderCategory == "Today")
                    ? BlocProvider.of<OrdersCubit>(context).todayOrders
                    : (selectedOrderCategory == "This Week")
                        ? BlocProvider.of<OrdersCubit>(context).thisWeekOrders
                        : (selectedOrderCategory == "This Month")
                            ? BlocProvider.of<OrdersCubit>(context)
                                .thisMonthOrders
                            : BlocProvider.of<OrdersCubit>(context).allOrders,
              );*/
          // const OrdersLabel(tittle: 'Today'),
          // OrdersListView(orders: todayOrders),
          // const HorizentalLine(),
          // const OrdersLabel(tittle: 'Yesterday'),
          // OrdersListView(orders: yesterdayOrders),
          // const HorizentalLine(),
          // const OrdersLabel(tittle: 'Last Week'),
          // OrdersListView(orders: thisWeekOrders),
          // const HorizentalLine(),
          // const HorizentalLine()*/