// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_avatar_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAvatarEntityAdapter extends TypeAdapter<UserAvatarEntity> {
  @override
  final int typeId = 8;

  @override
  UserAvatarEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAvatarEntity(
      colorValue: fields[0] as int,
      iconName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserAvatarEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.colorValue)
      ..writeByte(1)
      ..write(obj.iconName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAvatarEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
