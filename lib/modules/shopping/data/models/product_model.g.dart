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
      price: fields[4] as String,
      availablePieces: fields[5] as int,
      numAvailableSizes: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.numAvailableSizes);
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
