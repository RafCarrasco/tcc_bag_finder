// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traveler_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelerEntityAdapter extends TypeAdapter<TravelerEntity> {
  @override
  final int typeId = 5;

  @override
  TravelerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravelerEntity(
      id: fields[0] as String?,
      email: fields[1] as String,
      password: fields[2] as String,
      fullName: fields[3] as String,
      phone: fields[4] as String,
      avatar: fields[5] as UserAvatarEntity?,
      role: fields[6] as UserRoleEnum,
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
      bags: (fields[9] as List?)?.cast<TripEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, TravelerEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(9)
      ..write(obj.bags)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.avatar)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
