// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

// Project imports:
import '../theme/text_styles.dart';
import 'app_colors.dart';

GetSnackBar customSnackbar(String message) {
  return GetSnackBar(
    icon: Icon(
      Icons.error,
      color: AppColors.errorRedColor,
      size: 35,
    ),
    duration: 4.seconds,
    snackPosition: SnackPosition.TOP,
    titleText: Text(
      'Error',
      style: headingBlackStyle,
    ),
    messageText: Text(
      message,
      style: smallBold,
    ),
    backgroundColor: AppColors.primaryColorWithOpacity40,
  );
}

/* final AlertStyle defaultAlertStyle = AlertStyle(
  isCloseButton: false,
  titleStyle: headingBlackStyle,
  isButtonVisible: false,
  alertPadding: EdgeInsets.zero,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10.r),
      topRight: Radius.circular(10.r),
      bottomLeft: Radius.circular( 10.r),
      bottomRight: Radius.circular( 10.r),
    ),
  ),
  alertAlignment: Alignment.center,
  buttonAreaPadding: EdgeInsets.only(bottom: 18.h),
  overlayColor: Colors.black45,
);

final AlertStyle centeredAlertStyle = AlertStyle(
  isCloseButton: false,
  titleStyle: headingBlackStyle,
  isButtonVisible: false,
  alertPadding: EdgeInsets.zero,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.r),
  ),
  buttonAreaPadding: EdgeInsets.only(bottom: 18.h),
  overlayColor: Colors.black45,
);
 */