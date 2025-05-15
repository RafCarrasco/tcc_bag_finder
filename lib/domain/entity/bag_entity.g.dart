// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bag_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BagEntityAdapter extends TypeAdapter<BagEntity> {
  @override
  final int typeId = 1;

  @override
  BagEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BagEntity(
      id: fields[0] as String?,
      ownerId: fields[2] as String,
      description: fields[1] as String?,
      status: fields[3] as BagStatusEnum,
      createdAt: fields[4] as DateTime?,
      updatedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BagEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.ownerId)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BagEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
