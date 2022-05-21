import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final globalController = Get.find<GlobalController>();
  TextEditingController phoneResetTextEditingController =
      TextEditingController();

  void reset() async {
    await Auth()
        .resetPasswordEmail(phoneResetTextEditingController.text)
        .then((value) {
      Get.back();
    }).catchError((error) {
      Get.showSnackbar(
        customSnackbar(error.toString()),
      );
    });
  }
}
