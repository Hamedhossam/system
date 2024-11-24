// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      name: fields[0] as String,
      category: fields[6] as String,
      id: fields[1] as String,
      imagePath: fields[2] as String,
      availableSizes: (fields[3] as List?)?.cast<String>(),
      brand: fields[9] as String,
      numOfPiecesOrderd: fields[8] as int?,
      price: fields[4] as String,
      availablePieces: fields[5] as int,
      numAvailableSizes: fields[7] as int,
      priceAfterDiscount: fields[10] as String,
      discountPercentage: fields[11] as String,
      discountAmount: fields[12] as String,
      isPercentage: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.availableSizes)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.availablePieces)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.numAvailableSizes)
      ..writeByte(8)
      ..write(obj.numOfPiecesOrderd)
      ..writeByte(9)
      ..write(obj.brand)
      ..writeByte(10)
      ..write(obj.priceAfterDiscount)
      ..writeByte(11)
      ..write(obj.discountPercentage)
      ..writeByte(12)
      ..write(obj.discountAmount)
      ..writeByte(13)
      ..write(obj.isPercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
