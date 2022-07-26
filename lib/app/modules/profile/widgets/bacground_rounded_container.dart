import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../helpers/theme/app_colors.dart';

class BacgroundRoundedContainer extends StatelessWidget {
  const BacgroundRoundedContainer({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
          color: AppColors.whiteColor,
        ),
        width: double.infinity,
        height: 550.h,
        child: child);
  }
}
