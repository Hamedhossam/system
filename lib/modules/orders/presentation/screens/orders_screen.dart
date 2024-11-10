import 'package:flutter/material.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/modules/orders/presentation/widgets/all_orders.dart';
import 'package:motors/modules/orders/presentation/widgets/last_week_orders.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_label.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_screen_tittle.dart';
import 'package:motors/modules/orders/presentation/widgets/today_orders.dart';
import 'package:motors/modules/orders/presentation/widgets/yesterday_orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrdersScreenTittle(),
            HorizentalLine(),
            OrdersLabel(tittle: 'Today'),
            TodayOrders(),
            HorizentalLine(),
            OrdersLabel(tittle: 'Yesterday'),
            YesterdayOrders(),
            HorizentalLine(),
            OrdersLabel(tittle: 'Last Week'),
            LastWeekOrders(),
            HorizentalLine(),
            OrdersLabel(tittle: 'All'),
            AllOrders(),
            HorizentalLine()
          ],
        ),
      ),
    );
  }
}
