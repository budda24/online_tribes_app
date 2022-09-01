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
  final Function? onConfirm;
  final String? title;
  final String? content;

  Widget confirmBtn() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.errorRedColor)),
        onPressed: () {
          onConfirm!();
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

  showConfirmDialog() async {
    await Get.defaultDialog(
      title: title!,
      titleStyle: tribalFontLableRed,
      content: Text(
        content!,
        style: plainTextStyle,
        textAlign: TextAlign.center,
      ),
      barrierDismissible: true,
      radius: 50.0,
      confirm: confirmBtn(),
      cancel: cancelBtn(),
    );
  }

  Alerts.textInput({
    required this.onConfirm,
    required this.title,
    required this.content,
    required this.textFieldController,
    required this.savigInput,
  });
  TextEditingController? textFieldController;
  Function? savigInput;

  showInputDialog() async {
    await Get.defaultDialog(
        backgroundColor: AppColors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textFieldController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Type Name',
                  hintMaxLines: 1,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.actionColor, width: 4.0))),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.actionColor)),
              onPressed: () {
                if (textFieldController!.text.isNotEmpty) {
                  savigInput!();
                  Get.back();
                } else {
                  Get.showSnackbar(customSnackbar("Enter type name"));
                }
              },
              child: const Text(
                'ADD TRIBE TYPE',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            )
          ],
        ),
        radius: 10.0);
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