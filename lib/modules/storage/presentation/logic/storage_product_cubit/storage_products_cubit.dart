import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'storage_products_state.dart';

class StorageProductsCubit extends Cubit<StorageProductsState> {
  StorageProductsCubit() : super(StorageProductsInitial());
}
