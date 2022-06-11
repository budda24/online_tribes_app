// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// Project imports:

class SlimRoundedButton extends StatelessWidget {
  Color backgroundColour;
  Color textColor;
  String title;
  VoidCallback onPress;
  /* double screenWidth;
  double screenHeight; */

  SlimRoundedButton({
    required this.backgroundColour,
    required this.title,
    required this.textColor,
    required this.onPress,
    /* required this.screenWidth,
        required this.screenHeight */
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        surfaceIntensity:0.9,
        shadowLightColorEmboss:Colors.white,
        shadowLightColor: AppColors.primaryColor,
        depth:  -5,
        shape: NeumorphicShape.convex,
        lightSource: LightSource.bottomRight,
        // intensity:45,
        shadowDarkColor: Colors.black,
        color: AppColors.actionColor,
       
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
      ),
      padding:
          EdgeInsets.only(left: 40.w, right: 40.w, top: 2.h, bottom: 2.h),
      child: TextButton(

        child: Text(
          title,
          style:buttonLable
        ),
        onPressed: onPress,
      ),
    );
  }
}
