import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCirclePhoto extends StatelessWidget {
  MainCirclePhoto(
      {Key? key,
      required this.imageSize,
      required this.screeanwidth,
      required this.imagePathN,
      required this.screeanheight})
      : super(key: key);

  MainCirclePhoto.networking(
      {Key? key,
      required this.imageSize,
      required this.screeanheight,
      required this.screeanwidth,
      required this.imagePathN})
      : file = null,
        super(key: key);

  MainCirclePhoto.file(
      {Key? key,
      required this.imageSize,
      required this.screeanheight,
      required this.screeanwidth,
      required this.file})
      : imagePathN = '',
        super(key: key);
  MainCirclePhoto.icon(
      {Key? key,
      required this.imageSize,
      required this.screeanheight,
      required this.screeanwidth,
      required this.icon})
      : imagePathN = '',
        super(key: key);

  final double screeanheight;
  final double screeanwidth;
  double imageSize;
  Icon? icon;
  String imagePathN;
  File? file;

  /* final String imagePathL; */
  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize.w,
      height: imageSize.h,
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          width: 3.0,
          color: AppColors.white,
        ),
        shape: BoxShape.circle,
        image: DecorationImage(
            fit: BoxFit.fill,
            image: file == null
                ? NetworkImage(
                    imagePathN,
                  )
                : FileImage(file!)
                    as ImageProvider /* FileImage(file) */ /* fit: BoxFit.fill */
            ),
      ),
      child: icon,
    );
  }
}
