// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_state_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchivementStateHiveAdapter extends TypeAdapter<AchivementStateHive> {
  @override
  final int typeId = 3;

  @override
  AchivementStateHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AchivementStateHive.fail;
      case 1:
        return AchivementStateHive.success;
      case 2:
        return AchivementStateHive.pending;
      default:
        return AchivementStateHive.pending;
    }
  }

  @override
  void write(BinaryWriter writer, AchivementStateHive obj) {
    switch (obj) {
      case AchivementStateHive.fail:
        writer.writeByte(0);
        break;
      case AchivementStateHive.success:
        writer.writeByte(1);
        break;
      case AchivementStateHive.pending:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchivementStateHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
