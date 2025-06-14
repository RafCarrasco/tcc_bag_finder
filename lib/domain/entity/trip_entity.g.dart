// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripEntityAdapter extends TypeAdapter<TripEntity> {
  @override
  final int typeId = 7;

  @override
  TripEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripEntity(
      id: fields[0] as String?,
      responsibleCollaboratorId: fields[1] as String,
      description: fields[2] as TripDescriptionEntity,
      bags: (fields[4] as List?)?.cast<BagEntity>(),
      time: fields[3] as DateTime,
      isDone: fields[5] as bool,
      createdAt: fields[6] as DateTime?,
      updatedAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TripEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.responsibleCollaboratorId)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.bags)
      ..writeByte(5)
      ..write(obj.isDone)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
