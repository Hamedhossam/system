import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String imagePath;
  @HiveField(3)
  List<String>? availableSizes;
  @HiveField(4)
  String price;
  @HiveField(5)
  int availablePieces;
  @HiveField(6)
  final String category;
  @HiveField(7)
  int numAvailableSizes;
  @HiveField(8)
  int? numOfPiecesOrderd;
  @HiveField(9)
  String brand;
  @HiveField(10)
  String priceAfterDiscount;
  @HiveField(11)
  String discountPercentage;
  @HiveField(12)
  String discountAmount;
  @HiveField(13)
  bool isPercentage;

  ProductModel({
    required this.name,
    required this.category,
    required this.id,
    required this.imagePath,
    this.availableSizes,
    required this.brand,
    this.numOfPiecesOrderd,
    required this.price,
    required this.availablePieces,
    required this.numAvailableSizes,
    required this.priceAfterDiscount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.isPercentage,
  });
}
