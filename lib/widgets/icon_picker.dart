import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:success_factors/helps/consts.dart';

enum GridViewType { icon, color }

class IconPicker extends StatefulWidget {
  final Function(int, int) function;
  int? initialIconIndex;
  int? initialIconColorIndex;

  IconPicker({
    Key? key,
    required this.function,
    required this.initialIconIndex,
    required this.initialIconColorIndex,
  }) : super(key: key);

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  late int selectedIcon;
  late int selectedColor;

  @override
  void initState() {
    selectedIcon = widget.initialIconIndex ?? 0;
    selectedColor = widget.initialIconColorIndex ?? 0;

    super.initState();
    widget.function(selectedIcon, selectedColor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        genGridView(
          list: pickerIcons,
          function: ((index) {
            setState(() {
              selectedIcon = index;
              widget.function(selectedIcon, selectedColor);
            });
          }),
          selected: selectedIcon,
          selectedColor: selectedColor,
          type: GridViewType.icon,
        ),
        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: pickerIcons.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: pickerIcons.length),
        //   itemBuilder: (BuildContext context, int index) {
        //     return GestureDetector(
        //       onTap: () {
        //         setState(() {
        //           selectedIcon = index;
        //         });
        //       },
        //       child: Container(
        //         margin: const EdgeInsets.all(5),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: index == selectedIcon
        //                 ? Colors.black
        //                 : Colors.transparent,
        //             width: 1.0,
        //           ),
        //           borderRadius: BorderRadius.circular(5.0),
        //         ),
        //         child: genIcon(index, selectedColor),
        //       ),
        //     );
        //   },
        // ),
        const SizedBox(height: size30),
        genGridView(
          list: pickerColors,
          function: ((index) {
            setState(() {
              selectedColor = index;
              widget.function(selectedIcon, selectedColor);
            });
          }),
          selected: selectedColor,
          selectedColor: selectedColor,
          type: GridViewType.color,
        ),

        // GridView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: pickerColors.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: pickerColors.length),
        //   itemBuilder: (BuildContext context, int index) {
        //     return GestureDetector(
        //       onTap: () {
        // setState(() {
        //   selectedColor = index;
        // });
        //       },
        //       child: Container(
        //         margin: const EdgeInsets.all(5),
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: index == selectedColor
        //                 ? Colors.black
        //                 : Colors.transparent,
        //             width: 1.0,
        //           ),
        //           borderRadius: BorderRadius.circular(5.0),
        //           color: pickerColors[index],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }

  Widget genGridView(
      {required List list,
      required Function(int) function,
      required int selected,
      required int selectedColor,
      required GridViewType type}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: list.length),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            function(index);
          },
          child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: index == selected ? Colors.black : Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
                color: GridViewType.color == type
                    ? list[index]
                    : Colors.transparent,
              ),
              child: GridViewType.icon == type
                  ? genIcon(
                      icon: index,
                      color: selectedColor,
                      size: MediaQuery.of(context).size.width / 10)
                  : Container()),
        );
      },
    );
  }
}

Icon genIcon({
  required int icon,
  required int color,
  double? size,
}) {
  return Icon(
    pickerIcons[icon],
    color: pickerColors[color],
    size: size ?? 25,
  );
}
