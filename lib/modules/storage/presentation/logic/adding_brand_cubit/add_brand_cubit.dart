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

  Future<void> deleteBrand({required String brandName}) async {
    try {
      var brandsBox = Hive.box<String>("brands_box");
      var brandsList = brandsBox.values.toList();
      for (var i = 0; i < brandsList.length; i++) {
        if (brandsList[i].contains(brandName)) {
          await brandsBox.deleteAt(i);
        }
      }
      emit(AddBrandSuccess());
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(AddBrandFail());
    }
  }

  Future<void> editBrand(
      {required String brandName,
      required String newBrandName,
      required String newImagePath,
      required String category}) async {
    try {
      var brandsBox = Hive.box<String>("brands_box");
      var brandsList = brandsBox.values.toList();
      for (var i = 0; i < brandsList.length; i++) {
        if (brandsList[i].contains(brandName)) {
          await brandsBox.putAt(i, "$newBrandName $newImagePath $category");
        }
      }
      emit(AddBrandSuccess());
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(AddBrandFail());
    }
  }

  String removeLastTwoWords(String input) {
    // Split the string into words
    List<String> words = input.split(' ');

    // Check if there are at least two words
    if (words.length <= 2) {
      return ''; // Return an empty string if there are not enough words
    }

    // Remove the last two words and join the remaining words back into a string
    return words.sublist(0, words.length - 2).join(' ');
  }
}
