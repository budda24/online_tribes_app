// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

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

class Alerts {
  Alerts.confirmation({
    required this.onConfirm,
    required this.title,
    required this.content,
  });
  final Function onConfirm;
  final String title;
  final String content;

  showConfirmDialog() {
    Widget confirmBtn() {
      return ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.errorRedColor)),
          onPressed: () {
            onConfirm();
          },
          child: const Text("Confirm"));
    }

    Widget cancelBtn() {
      return ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.actionColor)),
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"));
    }

    Get.defaultDialog(
      title: title,
      titleStyle: tribalFontLableRed,
      /* middleText: "You content goes here...", */
      content: Text(
        content,
        style: plainTextStyle,
        textAlign: TextAlign.center,
      ),
      barrierDismissible: true,
      radius: 50.0,
      confirm: confirmBtn(),
      cancel: cancelBtn(),
    );
  }
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