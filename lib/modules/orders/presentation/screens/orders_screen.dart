import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/horizental_line.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/orders/presentation/widgets/order_widget.dart';
import 'package:motors/modules/orders/presentation/widgets/orders_screen_tittle.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late List<OrderModel> orders;
  late List<OrderModel> filteredorders;
  final TextEditingController searchController = TextEditingController();
  List<TimeButtons> timeButtons = const [
    TimeButtons(tittle: "All"),
    TimeButtons(tittle: "Today"),
    TimeButtons(tittle: "This Week"),
    TimeButtons(tittle: "This Month"),
  ];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrdersCubit>(context).getAllOrders();
    orders = BlocProvider.of<OrdersCubit>(context).orders;
    filteredorders = orders;
    searchController.addListener(filterProducts);
  }

  void filterProducts() {
    final query = searchController.text;

    if (mounted) {
      BlocProvider.of<OrdersCubit>(context).getfilteredOrders(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const OrdersScreenTittle(),
          const HorizentalLine(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: SizedBox(
              height: 100.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: timeButtons.length,
                  itemBuilder: (context, index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                          BlocProvider.of<OrdersCubit>(context)
                              .getTimePeriodOrders(timeButtons[index].tittle);
                        });
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.grey
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          timeButtons[index].tittle,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 600.w,
              child: CustomizedTextField(
                tittle: 'Search with id',
                maxLines: 1,
                controller: searchController,
                suffixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          BlocBuilder<OrdersCubit, OrdersCubitState>(
            builder: (context, state) {
              if (state is OrdersSearching) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(child: CircularProgressIndicator()));
              } else if (state is OrdersCubitSuccess) {
                filteredorders = state.ordersList;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.8,
                      ),
                      itemCount: filteredorders.length,
                      itemBuilder: (context, index) {
                        return OrderWidget(orderModel: filteredorders[index]);
                      },
                    ),
                  ),
                );
              } else if (state is OrdersCubitEmpty) {
                return Center(
                    child: Text(
                  'This is empty',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ));
              } else {
                return Center(
                    child: Text(
                  'No orders found',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}

class TimeButtons extends StatelessWidget {
  const TimeButtons({
    super.key,
    required this.tittle,
  });
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          tittle,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
