import 'package:flutter/material.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/reuse/add_update_view.dart';

class FloatingBtnAddAchievement extends StatefulWidget {
  VoidCallback callback;
  FloatingBtnAddAchievement({Key? key, required this.callback})
      : super(key: key);

  @override
  State<FloatingBtnAddAchievement> createState() =>
      _FloatingBtnAddAchievementState();
}

class _FloatingBtnAddAchievementState extends State<FloatingBtnAddAchievement> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      splashColor: Colors.black,
      backgroundColor: bg1,
      heroTag: 'achievment_add',
      label: const Icon(
        Icons.add,
        size: size30,
        color: text1,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUpdateView(
              title: 'ADD ACHIEVEMENT',
              heroTag: 'achievment_add',
              type: AddUpdateViewType.addAchievement,
            ),
          ),
        ).then((value) => widget.callback());
      },
    );
  }
}
