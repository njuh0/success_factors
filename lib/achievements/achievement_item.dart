import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:rive/rive.dart' as rive;

import 'package:success_factors/hive/achievement_hive.dart';
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
            motion: ScrollMotion(),
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
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              // decoration: BoxDecoration(
              //     border: Border(
              //         right: BorderSide(width: 1.0, color: Colors.black12))),
              child: Text(
                "${widget.element.getPercent().toStringAsFixed(2)}%",
                style: GoogleFonts.kanit(
                  fontSize: size15,
                  fontWeight: FontWeight.w600,
                  color: bg1,
                ),
              ),
            ),
            title: Text(
              textAlign: TextAlign.center,
              '"${widget.element.title}"',
              style: GoogleFonts.kanit(
                fontSize: size15,
                fontWeight: FontWeight.w600,
                color: bg1,
              ),
            ),
            trailing:
                genState(widget.element.state ?? AchivementStateHive.pending),
          ),
        ),
        // Divider(
        //   height: 0.5,
        //   color: Colors.black.withOpacity(0.1),
        // )
      ],
    );
  }

  Widget genState(AchivementStateHive state) {
    if (AchivementStateHive.pending == state) {
      return const SizedBox(
        height: 25,
        width: 25,
        child: rive.RiveAnimation.asset('assets/rive/puls2.riv',
            fit: BoxFit.fitWidth),
      );
    } else if (AchivementStateHive.fail == state) {
      return const Icon(
        Icons.cancel_rounded,
        // color: Color(0xFFEF9A9A),
        color: bg1,
        size: 25,
      );
    } else {
      return const Icon(
        Icons.done_rounded,
        // color: Color(0xFFEF9A9A),
        color: bg1,
        size: 25,
      );
    }
  }
}
