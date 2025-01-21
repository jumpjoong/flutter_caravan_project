// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerDataAdapter extends TypeAdapter<CustomerData> {
  @override
  final int typeId = 0;

  @override
  CustomerData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerData(
      name: fields[0] as String,
      room: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.room);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
