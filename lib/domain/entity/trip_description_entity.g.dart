// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_description_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripDescriptionEntityAdapter extends TypeAdapter<TripDescriptionEntity> {
  @override
  final int typeId = 6;

  @override
  TripDescriptionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TripDescriptionEntity(
      tripId: fields[0] as String,
      airportOrigin: fields[1] as String,
      airportDestination: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TripDescriptionEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.airportOrigin)
      ..writeByte(2)
      ..write(obj.airportDestination);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripDescriptionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
