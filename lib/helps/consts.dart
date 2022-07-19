import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

List<Color> pickerColors = [
  Colors.black,
  Colors.white,
  Colors.green[300]!,
  Colors.blue[300]!,
  Colors.yellowAccent,
  Colors.purple[100]!,
  Colors.orange[100]!,
];
const List<IconData> pickerIcons = [
  Icons.auto_awesome_sharp,
  Icons.emoji_objects,
  Icons.filter_vintage,
  Icons.cookie,
  Icons.cloud_rounded,
  Icons.cruelty_free_sharp,
  Icons.diamond,
];

const Color bg1 = Color(0xFF1A0F1D);
const Color text1 = Color(0xFFFF005F);

const List<Color> bgGradient1 = [
  Color(0xFFF39237),
  Color.fromARGB(255, 243, 55, 127),
];

const Widget animatedBg =
    rive.RiveAnimation.asset('assets/rive/bg2.riv', fit: BoxFit.fill);

const double padding30 = 30;

const double size120 = 120;
const double size30 = 30;
const double size20 = 20;
const double size15 = 15;
