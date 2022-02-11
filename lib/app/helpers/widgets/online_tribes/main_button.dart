
// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:



class SlimRoundedButton extends StatelessWidget {
  Color backgroundColour;
  Color textColor;
  String title;
  VoidCallback onPress;
  /* double screenWidth;
  double screenHeight; */

  SlimRoundedButton(
      {required this.backgroundColour,
        required this.title,
        required this.textColor,
        required this.onPress,
        /* required this.screenWidth,
        required this.screenHeight */});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(
            left: 61,
            right: 61,
            top: 8,
            bottom: 8)),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColour),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0.h)),
        ),
      ),
      child: Text(
        title,
        style:
        TextStyle(fontFamily: 'Montserrat', fontSize: 20, color: textColor),
      ),
      onPressed: onPress,
    );
  }
}