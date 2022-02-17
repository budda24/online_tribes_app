// Package imports:
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class GlobalController extends GetxController {
  String currentUserRole = '';
  final box = GetStorage();

   //custom snackBar
  void showSnackbar(String message) {
    Get.showSnackbar(GetSnackBar(
      duration: 3.seconds,
      snackPosition: SnackPosition.TOP,
      titleText: Text(
        'Error',
        style: headingStyle,
      ),
      messageText: Text(
        message,
        style: montserratBold,
      ),
      backgroundColor: AppColors.primaryColorWithOpacity40,
    ));
  }


  @override
  void onInit() async {
    /* if (box.read('isWalkthroughDone') == null ||
        !box.read('isWalkthroughDone')) {
    } else {
      print('Already Visited');
    } */
    super.onInit();
  }
}
