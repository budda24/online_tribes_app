import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCirclePhoto extends StatelessWidget {
  MainCirclePhoto(
      {required this.screeanwidth,
      required this.imagePathN,
      /* required this.imagePathL, */
      required this.screeanheight});

  MainCirclePhoto.networking(
      {required this.screeanheight,
      required this.screeanwidth,
      required this.imagePathN})
      : file = null;

  MainCirclePhoto.file(
      {required this.screeanheight,
      required this.screeanwidth,
      required this.file})
      : imagePathN = '';
  MainCirclePhoto.icon(
      {required this.screeanheight,
      required this.screeanwidth,
      required this.icon})
      : imagePathN = '';

  /* const MainCirclePhoto.local({
    required this.screeanheight,
    required this.screeanwidth,
    required this.imagePathL,


  }):imagePathN=''; */

  final double screeanheight;
  final double screeanwidth;
  Icon? icon;
  String imagePathN;
  File? file;
  /* final String imagePathL; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, bottom: 0),
      width: 200.w,
      height: 130.h,
      child: icon == null ? null : icon,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          width: 3.0,
          color: AppColors.whiteColor,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: file == null
                ? NetworkImage(imagePathN)
                : FileImage(file!)
                    as ImageProvider /* FileImage(file) */ /* fit: BoxFit.fill */
            ),
      ),
    );
  }
}
