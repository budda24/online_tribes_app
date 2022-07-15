import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class ExpandedContainer extends StatelessWidget {
  const ExpandedContainer(
      {Key? key,
      required this.expandFunction,
      required this.containerHeight,
      required this.text,
      required this.arrowPosition})
      : super(key: key);

  final Function expandFunction;
  final int containerHeight;
  final double arrowPosition;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Neumorphic(
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
          style: NeumorphicStyle(
            shadowLightColorEmboss: AppColors.primaryColor,
            /* shadowLightColor: AppColors.darkGreyColor, */
            depth: -5,
            shape: NeumorphicShape.convex,
            lightSource: LightSource.topLeft,
            intensity: 60,
            /* shadowDarkColor: AppColors.darkGreyColor, */
            color: AppColors.whiteColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(40)),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: 0.8.sw,
            height: containerHeight.h,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          top: arrowPosition,
          right: 140,
          child: InkWell(
            child: Image.asset('assets/icons/arrow_down_green.png'),
            onTap: () => expandFunction(),
          ),
        ),
      ],
    );
  }
}


