import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motors/core/widgets/customized_botton.dart';
import 'package:motors/core/widgets/text_field.dart';
import 'package:motors/modules/orders/logic/orders_cubit/orders_cubit.dart';
import 'package:motors/modules/orders/models/order_model.dart';
import 'package:motors/modules/orders/presentation/widgets/order_widget.dart';

class OrdersListView extends StatefulWidget {
  const OrdersListView({
    super.key,
    required this.orders,
  });
  final List<OrderModel> orders;

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  List<OrderModel> searchedOrders = [];
  final TextEditingController _searchController = TextEditingController();
  String idText = '';
  @override
  void initState() {
    super.initState();
    searchedOrders = BlocProvider.of<OrdersCubit>(context).searchedOrders;
    if (searchedOrders.isEmpty) {
      searchedOrders = widget.orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: SizedBox(
                  width: 200.w,
                  child: CustomizedTextField(
                    tittle: "Search with id",
                    maxLines: 1,
                    controller: _searchController,
                  ),
                ),
              ),
              SizedBox(
                width: 200.w,
                height: 65.h,
                child: CustomizedButton(
                  tittle: "Search",
                  myColor: Colors.blue,
                  onTap: () {
                    BlocProvider.of<OrdersCubit>(context).getSearchedOrders(
                      _searchController.text,
                      widget.orders,
                    );
                    searchedOrders =
                        BlocProvider.of<OrdersCubit>(context).searchedOrders;
                  },
                ),
              )
            ],
          ),
        ),
        BlocBuilder<OrdersCubit, OrdersCubitState>(
          builder: (context, state) {
            if (state is OrdersCubitFail) {
              return const Center(child: Text("something went wrong !"));
            } else if (state is OrdersSearching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (searchedOrders.isEmpty) {
                return Center(
                  child: Text(
                    "There is no Orders at This Time",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Row(
                  children: [
                    SizedBox(
                      height: 700.h,
                      width: 1780.w,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 4 items in a row
                          childAspectRatio:
                              1.5 / .8, // Aspect ratio for each item
                          mainAxisSpacing:
                              4.0, // Vertical spacing between items
                        ),
                        itemCount: searchedOrders.length,
                        itemBuilder: (context, index) {
                          return OrderWidget(orderModel: searchedOrders[index]);
                        },
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ],
    );
  }
}
