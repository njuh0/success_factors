import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/widgets/btn_transparent_text.dart';
import 'package:success_factors/widgets/floating_modal.dart';

class FloatingBtnMenu extends StatefulWidget {
  FloatingBtnMenu({Key? key}) : super(key: key);

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
                margin: EdgeInsets.only(bottom: 20),
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
                    SizedBox(
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
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'About',
                      style: GoogleFonts.kanit(
                          fontSize: size20,
                          fontWeight: FontWeight.w900,
                          color: bg1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Card(
                            color: bg1,
                            elevation: 20,
                            child: Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'Github',
                                  style: GoogleFonts.kanit(
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
                            child: Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  'License',
                                  style: GoogleFonts.kanit(
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
