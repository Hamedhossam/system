import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<OrderModel> yesterdayOrders = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrdersCubit>(context).getAllOrders();
    todayOrders = BlocProvider.of<OrdersCubit>(context).todayOrders;
    allOrders = BlocProvider.of<OrdersCubit>(context).allOrders;
    thisWeekOrders = BlocProvider.of<OrdersCubit>(context).thisWeekOrders;
    yesterdayOrders = BlocProvider.of<OrdersCubit>(context).yesterdayOrders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OrdersScreenTittle(),
            const HorizentalLine(),
            const OrdersLabel(tittle: 'Today'),
            BlocBuilder<OrdersCubit, OrdersCubitState>(
              builder: (context, state) {
                if (state is OrdersCubitFail) {
                  return const Center(child: Text("something went wrong !"));
                } else {
                  if (todayOrders.isEmpty) {
                    return const Center(
                      child: Text(
                        "There is no Orders at This Time",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return OrdersListView(orders: todayOrders);
                  }
                }
              },
            ),
            const HorizentalLine(),
            const OrdersLabel(tittle: 'Yesterday'),
            BlocBuilder<OrdersCubit, OrdersCubitState>(
              builder: (context, state) {
                if (state is OrdersCubitFail) {
                  return const Center(child: Text("something went wrong !"));
                } else {
                  if (yesterdayOrders.isEmpty) {
                    return const Center(
                      child: Text(
                        "There is no Orders at This Time",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return OrdersListView(orders: yesterdayOrders);
                  }
                }
              },
            ),
            const HorizentalLine(),
            const OrdersLabel(tittle: 'Last Week'),
            BlocBuilder<OrdersCubit, OrdersCubitState>(
              builder: (context, state) {
                if (state is OrdersCubitFail) {
                  return const Center(child: Text("something went wrong !"));
                } else {
                  if (thisWeekOrders.isEmpty) {
                    return const Center(
                      child: Text(
                        "There is no Orders at This Time",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return OrdersListView(orders: thisWeekOrders);
                  }
                }
              },
            ),
            const HorizentalLine(),
            const OrdersLabel(tittle: 'All'),
            BlocBuilder<OrdersCubit, OrdersCubitState>(
              builder: (context, state) {
                if (state is OrdersCubitFail) {
                  return const Center(child: Text("something went wrong !"));
                } else {
                  if (allOrders.isEmpty) {
                    return const Center(
                      child: Text(
                        "There is no Orders at This Time",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  } else {
                    return OrdersListView(orders: allOrders);
                  }
                }
              },
            ),
            const HorizentalLine()
          ],
        ),
      ),
    );
  }
}
