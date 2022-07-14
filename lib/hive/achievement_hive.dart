import 'package:hive_flutter/hive_flutter.dart';

import 'package:success_factors/hive/factor_hive.dart';

part 'achievement_hive.g.dart';

enum AchivementStateHive { fail, success, pending }

@HiveType(typeId: 1)
class AchievementHive {
  AchievementHive({
    required this.title,
    this.description,
    this.factors,
    this.state,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2, defaultValue: [])
  List<FactorHive>? factors;

  @HiveField(3)
  AchivementStateHive? state;

  double getPercent() {
    if (factors == null || factors!.isEmpty) return 0;
    double percent = 0;
    for (var factor in factors!) {
      percent += factor.percent;
    }
    return percent;
  }
}
