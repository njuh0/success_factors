import 'package:flutter/material.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/reuse/add_update_view.dart';

class FloatingBtnAddFactor extends StatefulWidget {
  VoidCallback callback;

  int index;
  FloatingBtnAddFactor({Key? key, required this.index, required this.callback})
      : super(key: key);

  @override
  State<FloatingBtnAddFactor> createState() => _FloatingBtnAddFactorState();
}

class _FloatingBtnAddFactorState extends State<FloatingBtnAddFactor> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      splashColor: Colors.black,
      backgroundColor: bg1,
      heroTag: 'achievment_factor_add',
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
                    title: 'ADD FACTOR',
                    heroTag: 'achievment_factor_add',
                    type: AddUpdateViewType.addFactor,
                    achievementIndex: widget.index,
                  )),
        ).then((value) => widget.callback());
      },
    );
  }
}
