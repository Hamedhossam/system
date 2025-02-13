import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:motors/modules/shopping/data/models/product_model.dart';

part 'storage_products_state.dart';

class StorageProductsCubit extends Cubit<StorageProductsState> {
  StorageProductsCubit() : super(StorageProductsInitial());
  List<ProductModel> allProducts = [];
  List<ProductModel> menProducts = [];
  List<ProductModel> womenProducts = [];
  List<ProductModel> bags = [];
  List<ProductModel> accessories = [];

  getAllProducts() {
    menProducts.clear();
    womenProducts.clear();
    bags.clear();
    accessories.clear();
    emit(StorageProductsLoading());
    try {
      var productsBox = Hive.box<ProductModel>("products_box");
      allProducts = productsBox.values.toList();
      allProducts = allProducts.reversed.toList();
      log(allProducts.length.toString());
      emit(StorageProductsSuccess());
    } on Exception catch (e) {
      emit(StorageProductsFailure());
      log(e.toString());
    }
    for (var i = 0; i < allProducts.length; i++) {
      switch (allProducts[i].category) {
        case "Shoes(Men)":
          menProducts.add(allProducts[i]);
        case "Shoes(Women)":
          womenProducts.add(allProducts[i]);
        case "Bags":
          bags.add(allProducts[i]);
        case "Accessories":
          accessories.add(allProducts[i]);
        default:
      }
    }
  }

  List<ProductModel> getProducts(String category) {
    switch (category) {
      case "Shoes(Men)":
        return menProducts;
      case "Shoes(Women)":
        return womenProducts;
      case "Bags":
        return bags;
      case "Accessories":
        log(accessories.length.toString());
        return accessories;
      default:
        return List.empty();
    }
  }

  String getPrice(String productName) {
    String price = "";
    for (var i = 0; i < allProducts.length; i++) {
      if (allProducts[i].name.contains(productName)) {
        price = allProducts[i].price;
        break;
      }
    }
    return price;
  }

  String getPriceAfterDiscount(String productName) {
    String price = "";
    for (var i = 0; i < allProducts.length; i++) {
      if (allProducts[i].name.contains(productName)) {
        price = "${allProducts[i].priceAfterDiscount} LE";
        break;
      }
    }
    return price;
  }

  String getDiscount(String productName) {
    String dicount = "";
    for (var i = 0; i < allProducts.length; i++) {
      if (allProducts[i].name.contains(productName)) {
        dicount = (allProducts[i].isPercentage)
            ? "- ${allProducts[i].discountPercentage}%"
            : "- ${allProducts[i].discountAmount} LE";
        break;
      }
    }
    return dicount;
  }

  deductTheNumberOfPiecesOfProducts(List<ProductModel> products) async {
    var productsBox = Hive.box<ProductModel>("products_box");
    allProducts = productsBox.values.toList();

    // Create a map for quick access
    var productsMap = {for (var product in products) product.name: product};

    for (var product in allProducts) {
      // Check if the current product exists in the ordered products
      if (productsMap.containsKey(product.name)) {
        var orderedProduct = productsMap[product.name];
        if (orderedProduct != null) {
          // Calculate new available pieces
          var newAvailablePieces =
              product.availablePieces - orderedProduct.numOfPiecesOrderd!;

          if (newAvailablePieces >= 0) {
            product.availablePieces = newAvailablePieces;
            await product.save();
          } else {
            // Handle the case where you would go negative
            print('Not enough available pieces for ${product.name}');
          }
        }
      }
    }

    // deductTheNumberOfPiecesOfProducts(List<ProductModel> products) async {
    //   var productsBox = Hive.box<ProductModel>("products_box");
    //   allProducts = productsBox.values.toList();
    //   for (var i = 0; i < allProducts.length; i++) {
    //     for (var j = 0; j < products.length; j++) {
    //       if (allProducts[i].name == products[j].name) {
    //         allProducts[i].availablePieces =
    //             allProducts[i].availablePieces - products[j].numOfPiecesOrderd!;
    //         await allProducts[i].save();
    //       }
    //     }
    //   }

    emit(StorageProductsSuccess());
  }

  ProductModel? getProductByName(String name) {
    List<ProductModel> products;
    var productsBox = Hive.box<ProductModel>("products_box");
    products = productsBox.values.toList();
    products = allProducts.reversed.toList();
    for (var i = 0; i < products.length; i++) {
      if (products[i].name == name) {
        return products[i];
      }
    }
    return null;
  }

  // bool isExist(String productName) {
  //   bool exist = false;
  //   var productsBox = Hive.box<ProductModel>("products_box");
  //   allProducts = productsBox.values.toList();
  //   for (var i = 0; i < allProducts.length; i++) {
  //     if (allProducts[i].name == productName) {
  //       exist = true;
  //       break;
  //     }
  //   }
  //   return exist;
  // }
}
