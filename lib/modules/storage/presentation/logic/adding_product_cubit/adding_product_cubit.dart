import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'adding_product_state.dart';

class AddingProductCubit extends Cubit<AddingProductState> {
  AddingProductCubit() : super(AddingProductInitial());
}
