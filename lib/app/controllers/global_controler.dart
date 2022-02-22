// Package imports:
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GlobalController extends GetxController {
  String currentUserRole = '';
  final box = GetStorage();

  User? user;
  void isUserLogged() {
    if (auth.currentUser != null) {
      user = auth.currentUser;
      Get.offAllNamed(Routes.HOME);
    } else {
      user = null;
      Get.offAll(LoginView());
    }
  }

  void unFocuseNode() {
    Get.focusScope!.unfocus();
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
