// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'factor_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FactorHiveAdapter extends TypeAdapter<FactorHive> {
  @override
  final int typeId = 2;

  @override
  FactorHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FactorHive(
      title: fields[0] as String,
      description: fields[1] as String?,
      percent: fields[2] as double,
      iconIndex: fields[3] as int,
      iconColorIndex: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FactorHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.percent)
      ..writeByte(3)
      ..write(obj.iconIndex)
      ..writeByte(4)
      ..write(obj.iconColorIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FactorHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
