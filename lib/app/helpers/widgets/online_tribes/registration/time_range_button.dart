import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class AvailableTimeButton extends StatelessWidget {
  const AvailableTimeButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(minHeight: 70.h, minWidth: 70.w),
      padding: EdgeInsets.zero,
      onPressed:  onPressed,
      icon: Container(
        height: 200.h,
        width: 200.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        child: Icon(
          Icons.access_alarms,
          size: 50.h,
          color: AppColors.blackColor,
        ),
      ),
    );
  }
}
