// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:rive/rive.dart' as rive;
import 'package:success_factors/achievements/achievement_item.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/hive/achievement_hive.dart';
import 'package:success_factors/hive/achievement_state_hive.dart';
import 'package:success_factors/provider/hive_provider.dart';
import 'package:success_factors/reuse/add_update_view.dart';
import 'package:success_factors/soap_bubble.dart';
import 'package:success_factors/widgets/floating_action_button/floating_btn_add_factor.dart';
import 'package:success_factors/widgets/floating_modal.dart';
import 'dart:math';

import 'package:success_factors/widgets/icon_picker.dart';

class AchievementView extends StatefulWidget {
  int index;
  AchievementView({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  List<SoapBubble> soapBubbles = [];

  late NavigatorState navigator;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      genSoapBubbles(MediaQuery.of(context).size.width);
    });
  }
    @override
  void didChangeDependencies() {
    navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    AchievementHive element = context.read<HiveProvider>().achi[widget.index];

    return ScaffoldGradientBackground(
      floatingActionButton: FloatingBtnAddFactor(
        index: widget.index,
        callback: () => setState(() {}),
      ),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: bgGradient1,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            pinned: true,
            actions: [
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(right:15),
                  child: genState(element.state ?? AchievementStateHive.pending, 25, text1),
                ),
                onTap: () async {
                  AchievementStateHive? result = await resultPopup(element.state ?? AchievementStateHive.pending);
                  if(result != null) {
                    element.state = result;
                    if(result != AchievementStateHive.pending){
                      element.analysis = await analysisPopup(result);
                    } else {
                      element.analysis = null;
                    }
                    await context.read<HiveProvider>().updateAchievement(element, widget.index);
                    setState(() {});
                  }
                },
              )],
            expandedHeight: MediaQuery.of(context).size.width * 0.89,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              title: GestureDetector(
                onTap: (() => achievementPopup(context, element, true)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    element.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, color: text1),
                  ),
                ),
              ),
              centerTitle: true,
              background: GestureDetector(
                onTap: (() => achievementPopup(context, element, true)),
                child: Stack(
                  children: [
                    rive.RiveAnimation.asset('assets/rive/new_file.riv',
                        fit: BoxFit.fitWidth),
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          "${element.getPercent().toStringAsFixed(2)}%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 8,
                              fontWeight: FontWeight.w900,
                              color: bg1),
                        ),
                      ),
                    ),
                    for (var item in soapBubbles)
                      Positioned(
                        left: item.left,
                        top: item.top,
                        height: item.size,
                        width: item.size,
                        child: rive.RiveAnimation.asset(
                          'assets/rive/bubble (2).riv',
                          // fit: BoxFit.fitWidth,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          if (element.factors != null)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  // Future.delayed(Duration(seconds: 1), () {
                  //   Slidable.of(context)?.dismiss(
                  //       ResizeRequest(Duration(milliseconds: 200), () {}));
                  // });
                  return GestureDetector(
                    child: Column(
                      children: [
                        Slidable(
                          key: UniqueKey(),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () async {
                              await context
                                  .read<HiveProvider>()
                                  .deleteFactor(widget.index, index);

                              setState(() {});
                            }),
                            children: [
                              SlidableAction(
                                onPressed: (context) async {
                                  await context
                                      .read<HiveProvider>()
                                      .deleteFactor(widget.index, index);
                                  setState(() {});
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
                                        title: 'EDIT FACTOR',
                                        type: AddUpdateViewType.updateFactor,
                                        achievementIndex: widget.index,
                                        factorIndex: index,
                                        element: element,
                                      ),
                                    ),
                                  ).then((value) => setState(
                                      () {})); // setState to update view if user close keyboard (keyboard close causes view refresh) before add item. view don't refresh after item add
                                },
                                backgroundColor: bg1,
                                foregroundColor: text1,
                                icon: Icons.edit,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  // decoration: BoxDecoration(
                                  //     border: Border(
                                  //         right: BorderSide(
                                  //             width: 1.0, color: Colors.black12))),
                                  child: Text(
                                    "${element.factors![index].percent.toStringAsFixed(2)}%",
                                    style: const TextStyle(
                                        fontSize: size15, color: bg1),
                                  ),
                                ),

                                title: Text(
                                  textAlign: TextAlign.center,
                                  element.factors![index].title,
                                  style: TextStyle(
                                      fontSize: size15,
                                      fontWeight: FontWeight.w600,
                                      color: bg1),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                // subtitle: Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: <Widget>[
                                //     Icon(Icons.auto_awesome_sharp,
                                //         color: Colors.yellowAccent),
                                //     Text("10%", style: TextStyle(color: Colors.white))
                                //   ],
                                // ),
                                trailing: genIcon(
                                  icon: element.factors![index].iconIndex,
                                  color: element.factors![index].iconColorIndex,
                                ),
                              ),
                              // Divider(
                              //   height: 1.5,
                              //   color: Colors.black.withOpacity(0.1),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showFloatingModalBottomSheet(
                        backgroundColor: pickerColors[
                            element.factors![index].iconColorIndex],
                        context: context,
                        builder: (context) {
                          Color textColor =
                              element.factors![index].iconColorIndex == 0
                                  ? Colors.orange[100]!
                                  : bg1;

                          return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            element.factors![index].title,
                                            style: TextStyle(
                                                fontSize: size30,
                                                fontWeight: FontWeight.w900,
                                                color: textColor),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: textColor,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // ↑ to remove showFloatingModalBottomSheet
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddUpdateView(
                                                    title: 'EDIT FACTOR',
                                                    type: AddUpdateViewType
                                                        .updateFactor,
                                                    achievementIndex:
                                                        widget.index,
                                                    factorIndex: index,
                                                    element: element,
                                                  ),
                                                ),
                                              ).then((value) => setState(
                                                  () {})); // setState to update view if user close keyboard (keyboard close causes view refresh) before add item. view don't refresh after item add
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (element.factors![index].description !=
                                        null)
                                      Text(
                                        element.factors![index].description!,
                                        style: TextStyle(
                                            fontSize: size15,
                                            fontWeight: FontWeight.w900,
                                            color: textColor),
                                      ),
                                  ]),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                childCount: element.factors!.length,
              ),
            ),
          const SliverToBoxAdapter(
            child: SizedBox(height: size120),
          )
        ],
      ),
    );
  }
  Future<AchievementStateHive?> resultPopup(AchievementStateHive currentState) async {
    AchievementStateHive? state;
    await showFloatingModalBottomSheet(
          backgroundColor: text1,
          context: context,
          builder: (contextB) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(30),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          "THE RESULT OF EFFORTS",
                          style: TextStyle(
                              fontSize: size30,
                              fontWeight: FontWeight.w900,
                              color: bg1),
                        ),
                      ),
                      SizedBox(height:50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if(currentState != AchievementStateHive.pending)
                          GestureDetector(
                            onTap: (){
                              state = AchievementStateHive.pending;
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(child: genState(AchievementStateHive.pending, 50, bg1), backgroundColor: bg1),
                          ),
                        if(currentState != AchievementStateHive.success)
                           GestureDetector(
                            onTap: (){
                              state = AchievementStateHive.success;
                              Navigator.pop(context);
                            },
                            child: genState(AchievementStateHive.success, 50, bg1),
                          ),
                        if(currentState != AchievementStateHive.fail)
                           GestureDetector(
                            onTap: (){
                              state = AchievementStateHive.fail;
                              Navigator.pop(context);
                            },
                            child: genState(AchievementStateHive.fail, 50, bg1),
                          ),
                      ])
                    ]),
              ),
            );
          },
    );
    return state;
  }

  Future<String?> analysisPopup(AchievementStateHive result) async {
    String? analysis;
    await showFloatingModalBottomSheet(
          backgroundColor: text1,
          context: context,
          builder: (contextB) {
            TextEditingController c = TextEditingController();
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(30),
                child: Column(                        
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                              "Analyze your result",
                              style: TextStyle(
                                  fontSize: size30,
                                  fontWeight: FontWeight.w900,
                                  color: bg1),
                            ),
                          ),
                          IconButton(
                          icon: Icon(Icons.done_rounded, color: bg1, size: size30),
                          onPressed: (){
                            analysis = c.text;
                            Navigator.pop(context);
                          },
                        ),
                        ],
                      ),
                      SizedBox(height:10),
                      Text(
                        result == AchievementStateHive.success ? "Why you succeeded?" : (result == AchievementStateHive.fail ? "Why you failed?" : ""),
                        style: TextStyle(
                            fontSize: size15,
                            color: bg1),
                      ),
                      SizedBox(height:20),
                      Center(
                        child: TextField(
                        controller: c,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(width: 0.5, color: bg1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                        ),
                        
                          ),
                      ),
                      SizedBox(height:50),
                    
                    ]),
              ),
            );
          },
    );
    return analysis;
  }


  void achievementPopup(BuildContext context, AchievementHive element, bool isAchievement) {
    showFloatingModalBottomSheet(
      backgroundColor: text1,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(30),
            child: 
            Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      element.title,
                      style: TextStyle(
                          fontSize: size30,
                          fontWeight: FontWeight.w900,
                          color: bg1),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: bg1,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        // ↑ to remove showFloatingModalBottomSheet
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUpdateView(
                              title: 'EDIT ACHIEVEMENT',
                              type: AddUpdateViewType.updateAchievement,
                              fromFactor: isAchievement,
                              achievementIndex: widget.index,
                              element: element,
                            ),
                          ),
                        ).then((value) {
                          if(value == "Deleted"){
                                 navigator.pop();
                          } else {
                            setState(() {});
                          }
                         
                        }); // setState to update view if user close keyboard (keyboard close causes view refresh) before add item. view don't refresh after item add
                      },
                    ),
                  ),
                ],
              ),
              if (element.description != null)
                Text(
                  element.description!,
                  style: TextStyle(
                      fontSize: size15,
                      fontWeight: FontWeight.w900,
                      color: bg1),
                ),
            ]),
          ),
        );
      },
    );
  }

  genSoapBubbles(double screenWidth) {
    soapBubbles = [];
    Random r = Random();
    int count = r.nextInt(4) + 1;
    for (var i = 0; i < count; i++) {
      double size = r.nextDouble() * 100 + 10;
      double top = r.nextDouble() * (screenWidth - (size * 2)) + 10;
      double left = r.nextDouble() * (screenWidth - (size * 2)) + 10;
      soapBubbles.add(SoapBubble(top: top, left: left, size: size));
    }
    setState(() {});
  }
}
