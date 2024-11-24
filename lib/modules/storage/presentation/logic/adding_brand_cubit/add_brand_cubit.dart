import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'add_brand_state.dart';

class AddBrandCubit extends Cubit<AddBrandState> {
  AddBrandCubit() : super(AddBrandInitial());
  List<String> allBrands = [];
  List<String> menBrands = [];
  List<String> womenBrands = [];
  List<String> bagsBrands = [];
  List<String> accessoriesBrands = [];

  getBrands() {
    menBrands.clear();
    womenBrands.clear();
    bagsBrands.clear();
    accessoriesBrands.clear();
    var brandsBox = Hive.box<String>("brands_box");
    allBrands = brandsBox.values.toList();
    for (var i = 0; i < allBrands.length; i++) {
      if (allBrands[i].endsWith("Shoes(Men)")) {
        menBrands.add(allBrands[i]);
      } else if (allBrands[i].endsWith("Shoes(Women)")) {
        womenBrands.add(allBrands[i]);
      } else if (allBrands[i].endsWith("Bags")) {
        bagsBrands.add(allBrands[i]);
      } else {
        accessoriesBrands.add(allBrands[i]);
      }
    }
  }

  Future<void> addBrand({
    required String category,
    required String brandName,
    required String imagePath,
  }) async {
    menBrands.clear();
    womenBrands.clear();
    bagsBrands.clear();
    accessoriesBrands.clear();
    emit(AddBrandInitial());
    try {
      var brandsBox = Hive.box<String>("brands_box");
      await brandsBox.add("$brandName $imagePath $category");
      // brandsBox.clear();
      allBrands = brandsBox.values.toList();
      for (var i = 0; i < allBrands.length; i++) {
        if (allBrands[i].endsWith("Shoes(Men)")) {
          menBrands.add(allBrands[i]);
        } else if (allBrands[i].endsWith("Shoes(Women)")) {
          womenBrands.add(allBrands[i]);
        } else if (allBrands[i].endsWith("Bags")) {
          bagsBrands.add(allBrands[i]);
        } else {
          accessoriesBrands.add(allBrands[i]);
        }
      }
      log(menBrands.toString());
      emit(AddBrandSuccess());
      log(allBrands.toString());
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(AddBrandFail());
    }
  }
}
