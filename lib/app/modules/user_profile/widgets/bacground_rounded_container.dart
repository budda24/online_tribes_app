//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';

class BacgroundRoundedContainer extends StatelessWidget {
  BacgroundRoundedContainer({
    Key? key,
    required this.child,
  })  : height = 550.h,
        super(key: key);
  BacgroundRoundedContainer.profile(
      {Key? key, required this.child, required this.height})
      : super(key: key);
  final Widget child;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
          color: AppColors.white,
        ),
        width: double.infinity,
        height: height,
        child: child);
  }
}
