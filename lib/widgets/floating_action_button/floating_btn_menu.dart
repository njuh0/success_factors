import 'package:flutter/material.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/widgets/btn_transparent_text.dart';
import 'package:success_factors/widgets/floating_modal.dart';

class FloatingBtnMenu extends StatefulWidget {
  const FloatingBtnMenu({Key? key}) : super(key: key);

  @override
  State<FloatingBtnMenu> createState() => _FloatingBtnMenuState();
}

class _FloatingBtnMenuState extends State<FloatingBtnMenu> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      splashColor: Colors.black,
      backgroundColor: bg1,
      label: const Icon(
        Icons.menu_rounded,
        size: size30,
        color: text1,
      ),
      onPressed: () {
        showFloatingModalBottomSheet(
          backgroundColor: text1,
          backgroundWidget: animatedBg,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                // color: bg1,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          // behavior: HitTestBehavior.translucent,
                          child: BtnTransparentText(text: 'READ ME'),
                          onTap: () {
                            print('READ ME');
                          },
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          // behavior: HitTestBehavior.translucent,
                          child: BtnTransparentText(text: 'ANALYSIS'),
                          onTap: () {
                            print('READ ME');
                          },
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'About',
                      style: TextStyle(
                          fontSize: size20,
                          fontWeight: FontWeight.w900,
                          color: bg1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          child: Card(
                            color: bg1,
                            elevation: 20,
                            child: SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Github',
                                  style: TextStyle(
                                      fontSize: size15,
                                      fontWeight: FontWeight.w900,
                                      color: text1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Card(
                            color: bg1,
                            elevation: 20,
                            child: SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'License',
                                  style: TextStyle(
                                      fontSize: size15,
                                      fontWeight: FontWeight.w900,
                                      color: text1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
