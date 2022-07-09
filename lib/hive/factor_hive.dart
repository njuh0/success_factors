import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'factor_hive.g.dart';

@HiveType(typeId: 2)
class FactorHive {
  FactorHive({
    required this.title,
    this.description,
    required this.percent,
    required this.iconIndex,
    required this.iconColorIndex,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  double percent;

  @HiveField(3)
  int iconIndex;

  @HiveField(4)
  int iconColorIndex;
}
