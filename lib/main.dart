import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/controllers/global_controller.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/walkthrough/controllers/walkthrough_controller.dart';
import 'package:flutter_application_1/app/modules/walkthrough/views/walkthrough_view.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/helpers/theme/form_field_styles.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  final controller = Get.put(GlobalController());
  Get.put(WalkthroughController());

  var defaultScreen;

  if (Get.find<GlobalController>().box.read('isWalkthroughDone') != null &&
      Get.find<GlobalController>().box.read('isWalkthroughDone')) {
    defaultScreen = LoginView();
  } else {
    defaultScreen = WalkthroughView();
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      home: defaultScreen,
      theme: ThemeData(
        inputDecorationTheme: outlineInputTextFormFieldStyle
      ),
      /* initialRoute: AppPages.INITIAL, */
      getPages: AppPages.routes,
    ),
  );
}
