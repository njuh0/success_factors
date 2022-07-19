import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:rive/rive.dart' as rive;

import 'package:success_factors/hive/achievement_hive.dart';
import 'package:success_factors/hive/achievement_state_hive.dart';
import 'package:success_factors/provider/hive_provider.dart';
import 'package:success_factors/reuse/add_update_view.dart';

class AchievementItem extends StatefulWidget {
  VoidCallback callback;
  AchievementHive element;
  int index;
  AchievementItem({
    Key? key,
    required this.callback,
    required this.element,
    required this.index,
  }) : super(key: key);

  @override
  State<AchievementItem> createState() => _AchievementItemState();
}

class _AchievementItemState extends State<AchievementItem> {
  final _key = GlobalKey();
  double successHeight = 0;

  getSuccessHeight(_) {
    final size = _key.currentContext?.size;
    if (size != null) {
      setState(() {
        successHeight = size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(getSuccessHeight);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slidable(
          key: UniqueKey(),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: DismissiblePane(onDismissed: () async {
              await context
                  .read<HiveProvider>()
                  .deleteAchievement(widget.index);

              widget.callback();
            }),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  await context
                      .read<HiveProvider>()
                      .deleteAchievement(widget.index);
                  widget.callback();
                },
                backgroundColor: bg1,
                foregroundColor: text1,
                icon: Icons.delete,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUpdateView(
                        title: 'EDIT ACHIEVEMENT',
                        type: AddUpdateViewType.updateAchievement,
                        achievementIndex: widget.index,
                        element: widget.element,
                      ),
                    ),
                  ).then((value) => widget.callback());
                },
                backgroundColor: bg1,
                foregroundColor: text1,
                icon: Icons.edit,
              ),
            ],
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              child: Text(
                "${widget.element.getPercent().toStringAsFixed(2)}%",
                style: const TextStyle(fontSize: size15, color: bg1),
              ),
            ),
            subtitle: Text(
              widget.element.analysis ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: size15, color: bg1),
            ),
            title: Text(
              '"${widget.element.title}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: size15, fontWeight: FontWeight.w600, color: bg1),
            ),
            trailing:
                genState(widget.element.state ?? AchievementStateHive.pending, 25, bg1),
          ),
        ),
        // Divider(
        //   height: 0.5,
        //   color: Colors.black.withOpacity(0.1),
        // )
      ],
    );
  }
}
  Widget genState(AchievementStateHive state, double size, Color color) {
    if (AchievementStateHive.pending == state) {
      return  SizedBox(
        height: size,
        width: size,
        child: rive.RiveAnimation.asset('assets/rive/puls2.riv',
            fit: BoxFit.fitWidth),
      );
    } else if (AchievementStateHive.fail == state) {
      return  Icon(
        Icons.cancel_rounded,
        // color: Color(0xFFEF9A9A),
        color: color,
        size: size,
      );
    } else {
      return  Icon(
        Icons.check_circle_rounded,
        // color: Color(0xFFEF9A9A),
        color: color,
        size: size,
      );
    }
  }