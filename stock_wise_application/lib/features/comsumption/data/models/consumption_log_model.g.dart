// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumption_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConsumptionLogModelAdapter extends TypeAdapter<ConsumptionLogModel> {
  @override
  final int typeId = 6;

  @override
  ConsumptionLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConsumptionLogModel(
      id: fields[0] as String,
      productId: fields[1] as String,
      productName: fields[2] as String,
      quantityUsed: fields[3] as double,
      date: fields[4] as DateTime,
      cost: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ConsumptionLogModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.productName)
      ..writeByte(3)
      ..write(obj.quantityUsed)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConsumptionLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
