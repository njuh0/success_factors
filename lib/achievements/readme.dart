import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:success_factors/helps/consts.dart';

class Readme extends StatefulWidget {
  const Readme({Key? key}) : super(key: key);

  @override
  _ReadmeState createState() => _ReadmeState();
}

class _ReadmeState extends State<Readme> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: bgGradient1,
      ),
      appBar: AppBar(
        title: Text(
          'READ ME',
          style: const TextStyle(fontWeight: FontWeight.w900, color: text1),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("The app helps you to",
              style: TextStyle(
                fontSize: size30,
                fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("♡ Keep track of your goal",
              style: TextStyle(
                fontSize: size20,
                //fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("♡ Learn to assess the likelihood of success",
              style: TextStyle(
                fontSize: size20,
                //fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("♡ Analyze result",
              style: TextStyle(
                fontSize: size20,
                //fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("Tricky Control",
              style: TextStyle(
                fontSize: size30,
                fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("꩜ Items in the list can be swiped left and right",
              style: TextStyle(
                fontSize: size20,
                //fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("꩜ Achievements can be marked as completed by clicking on the top right icon in the achievement view",
              style: TextStyle(
                fontSize: size20,
                //fontWeight: FontWeight.w900,
                color: bg1),
              ),
              Text("",
              style: TextStyle(
                fontSize: size30,
                fontWeight: FontWeight.w900,
                color: bg1),
              ),
            ],
          ),
        ),
      )
    );
  }
}