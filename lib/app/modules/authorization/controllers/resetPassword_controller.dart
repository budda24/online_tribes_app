import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import '../../../helpers/controllers/global_controller.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  /* final globalController = Get.find<GlobalController>();
  TextEditingController emailController = TextEditingController();

  void reset() async {
    await Auth().restPasswordEmail(emailController.text).then((value) {
      Get.back();
    }).catchError((error) {
      Get.showSnackbar(
        customSnackbar(error.toString()),
      );
    });
  } */
}
