// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradientCardAdapter extends TypeAdapter<GradientCard> {
  @override
  GradientCard read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradientCard(
      (fields[0] as List)?.cast<double>(),
      (fields[1] as List)?.cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, GradientCard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.primaryColor)
      ..writeByte(1)
      ..write(obj.secondaryColor);
  }
}
