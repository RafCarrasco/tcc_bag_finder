// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportEntityAdapter extends TypeAdapter<ReportEntity> {
  @override
  final int typeId = 3;

  @override
  ReportEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportEntity(
      id: fields[0] as String,
      description: fields[1] as String,
      userId: fields[2] as UserEntity,
      bagEntity: fields[3] as BagEntity,
    );
  }

  @override
  void write(BinaryWriter writer, ReportEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.bagEntity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
