import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:success_factors/helps/consts.dart';

// miracle widget
class BtnTransparentText extends StatefulWidget {
  String text;
  BtnTransparentText({Key? key, required this.text}) : super(key: key);

  @override
  State<BtnTransparentText> createState() => _BtnTransparentTextState();
}

class _BtnTransparentTextState extends State<BtnTransparentText> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        height: 100,
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(bg1, BlendMode.srcOut),
          child: Stack(
            // fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: bg1,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.kanit(
                      fontSize: size30,
                      fontWeight: FontWeight.w900,
                      color: text1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
