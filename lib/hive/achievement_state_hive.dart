import 'package:hive_flutter/hive_flutter.dart';

part 'achievement_state_hive.g.dart';

@HiveType(typeId: 3)
enum AchivementStateHive {
  @HiveField(0)
  fail,
  @HiveField(1)
  success,
  @HiveField(2, defaultValue: true)
  pending,
}
