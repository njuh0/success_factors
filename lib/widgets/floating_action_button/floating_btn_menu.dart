import 'package:flutter/material.dart';
import 'package:success_factors/achievements/credits.dart';
import 'package:success_factors/achievements/readme.dart';
import 'package:success_factors/helps/consts.dart';
import 'package:success_factors/widgets/btn_transparent_text.dart';
import 'package:success_factors/widgets/floating_modal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
                            child: kIsWeb
                                ? Container(
                                    color: bg1,
                                    height: 100,
                                    child: const Center(
                                      child: Text(
                                        'READ ME',
                                        style: TextStyle(
                                            fontSize: size30,
                                            fontWeight: FontWeight.w900,
                                            color: text1),
                                      ),
                                    ),
                                  )
                                : BtnTransparentText(text: 'READ ME'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Readme()));
                            },
                          ),
                        ),
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
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (!await launchUrl(Uri.parse(
                                  'https://github.com/njuh0/success_factors'))) {
                                throw 'error lauch';
                              }
                            },
                            child: const Card(
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
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Credits()));
                            },
                            child: const Card(
                              color: bg1,
                              elevation: 20,
                              child: SizedBox(
                                height: 100,
                                child: Center(
                                  child: Text(
                                    'Credits',
                                    style: TextStyle(
                                        fontSize: size15,
                                        fontWeight: FontWeight.w900,
                                        color: text1),
                                  ),
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
