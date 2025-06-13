// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collaborator_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollaboratorEntityAdapter extends TypeAdapter<CollaboratorEntity> {
  @override
  final int typeId = 2;

  @override
  CollaboratorEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollaboratorEntity(
      id: fields[0] as String?,
      email: fields[1] as String,
      password: fields[2] as String,
      fullName: fields[3] as String,
      dateOfBirth: fields[4] as String,
      phone: fields[5] as String,
      company: fields[10] as String,
      isActive: fields[11] as bool,
      responsibleId: fields[12] as String,
      avatar: fields[6] as UserAvatarEntity?,
      role: fields[7] as UserRoleEnum,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CollaboratorEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(10)
      ..write(obj.company)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.responsibleId)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.dateOfBirth)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.avatar)
      ..writeByte(7)
      ..write(obj.role)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollaboratorEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
