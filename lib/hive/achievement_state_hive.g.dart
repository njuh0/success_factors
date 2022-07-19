// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_state_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchivementStateHiveAdapter extends TypeAdapter<AchievementStateHive> {
  @override
  final int typeId = 3;

  @override
  AchievementStateHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AchievementStateHive.fail;
      case 1:
        return AchievementStateHive.success;
      case 2:
        return AchievementStateHive.pending;
      default:
        return AchievementStateHive.pending;
    }
  }

  @override
  void write(BinaryWriter writer, AchievementStateHive obj) {
    switch (obj) {
      case AchievementStateHive.fail:
        writer.writeByte(0);
        break;
      case AchievementStateHive.success:
        writer.writeByte(1);
        break;
      case AchievementStateHive.pending:
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
