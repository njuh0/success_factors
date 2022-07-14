import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:rive/rive.dart' as rive;
import 'package:success_factors/achievements/achievement_item.dart';
import 'package:success_factors/achievements/achievement_view/achievement_view.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/provider/hive_provider.dart';
import 'package:success_factors/widgets/floating_action_button/floating_btn_add_achievement.dart';
import 'package:success_factors/widgets/floating_action_button/floating_btn_menu.dart';

class Achievements extends StatefulWidget {
  const Achievements({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var achievements = context.read<HiveProvider>().achi;
    // print(achievements.length);
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: bgGradient1,
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                stretch: true,
                expandedHeight: MediaQuery.of(context).size.width * 0.89,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, color: text1),
                  ),
                  centerTitle: true,
                  background: const rive.RiveAnimation.asset(
                      'assets/rive/space_coffee.riv',
                      fit: BoxFit.fitWidth),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: AchievementItem(
                        element: achievements[index],
                        index: index,
                        callback: () => setState(() {}),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AchievementView(index: index)),
                        ).then((value) => setState(() {}));
                      },
                    );
                  },
                  childCount: achievements.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomLeft,
            child: const FloatingBtnMenu(),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: FloatingBtnAddAchievement(callback: () => setState(() {})),
          ),
        ],
      ),
    );
  }
}
