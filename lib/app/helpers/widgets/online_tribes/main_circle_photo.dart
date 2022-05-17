import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';

class MainCirclePhoto extends StatelessWidget {
  MainCirclePhoto(
      {required this.screeanwidth,
      required this.imagePathN,
      /* required this.imagePathL, */
      required this.screeanheight});

  MainCirclePhoto.networking(
      {required this.screeanheight,
      required this.screeanwidth,
      required this.imagePathN}) : file = null;

   MainCirclePhoto.file({
    required this.screeanheight,
    required this.screeanwidth,
    required this.file
  }) : imagePathN = '';

  /* const MainCirclePhoto.local({
    required this.screeanheight,
    required this.screeanwidth,
    required this.imagePathL,


  }):imagePathN=''; */

  final double screeanheight;
  final double screeanwidth;
  String imagePathN;
  File? file;
  /* final String imagePathL; */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 10.h, bottom: 0),
      width: 140.w,
      height: 70.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 5.0,
          color: AppColors.facebookColor,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: file == null ? NetworkImage(imagePathN) : FileImage(file!) as ImageProvider/* FileImage(file) */ /* fit: BoxFit.fill */
        ),
      ),
    );
  }
}
