// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScannerEntityAdapter extends TypeAdapter<ScannerEntity> {
  @override
  final int typeId = 4;

  @override
  ScannerEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScannerEntity(
      id: fields[0] as String,
      isActive: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScannerEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScannerEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
