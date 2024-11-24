import 'package:hive/hive.dart';
part 'order_model.g.dart';

@HiveType(typeId: 1)
class OrderModel extends HiveObject {
  @HiveField(0)
  List<String> products;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String clientName;
  @HiveField(3)
  String clientPhone;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final double price;

  OrderModel({
    required this.id,
    required this.clientName,
    required this.date,
    required this.price,
    required this.clientPhone,
    required this.products,
  });
}
