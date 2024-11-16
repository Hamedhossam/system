import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orders_cubit_state.dart';

class OrdersCubitCubit extends Cubit<OrdersCubitState> {
  OrdersCubitCubit() : super(OrdersCubitInitial());
}
