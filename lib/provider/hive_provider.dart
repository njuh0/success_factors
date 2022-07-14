import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:success_factors/hive/achievement_hive.dart';

class HiveProvider with ChangeNotifier {
  List<AchievementHive> achi = [];

  Future<bool> initAchi() async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    achi = box.values.toList();
    notifyListeners();
    return true;
  }

  Future getAchi() async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    achi = box.values.toList();
    notifyListeners();
  }

  Future addAchievement(AchievementHive element) async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    await box.add(element);
    achi = box.values.toList();
    notifyListeners();
  }

  Future updateAchievement(AchievementHive element, int index) async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    await box.putAt(index, element);
    achi = box.values.toList();
    notifyListeners();
  }

  Future deleteAchievement(int index) async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    await box.deleteAt(index);
    achi = box.values.toList();
    notifyListeners();
  }

  Future deleteFactor(int achievementIndex, int factorIndex) async {
    Box<AchievementHive> box = await Hive.openBox<AchievementHive>('achi');
    AchievementHive element = box.getAt(achievementIndex)!;
    element.factors!.removeAt(factorIndex);
    await box.putAt(achievementIndex, element);
    achi = box.values.toList();
    notifyListeners();
  }
}
