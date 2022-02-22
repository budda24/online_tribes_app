import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/walkthrough/controllers/walkthrough_controller.dart';
import 'package:flutter_application_1/app/modules/walkthrough/views/walkthrough_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/global_bindings.dart';
import 'app/controllers/global_controler.dart';
import 'app/helpers/theme/form_field_styles.dart';
/* import 'app/modules/registration/views/registration_aditional_view.dart';
import 'app/modules/registration/views/registration_user_view.dart'; */
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  /* init global controler for storing the walltktrough visited */
  final controller = Get.put(GlobalController());
  /* init waltrough controler riting the is visited to the global box */
  Get.put(WalkthroughController());

  var defaultScreen;

/*if visited set home to loginscree  */
  if (Get.find<GlobalController>().box.read('isWalkthroughDone') != null &&
      Get.find<GlobalController>().box.read('isWalkthroughDone')) {
    defaultScreen = Routes.LOGIN;
  } else {
    defaultScreen = Routes.WALKTHROUGH;
  }
  if (FirebaseAuth.instance.currentUser == null) {
    print('User is currently signed out!');
    defaultScreen = Routes.LOGIN;
  } else {
    defaultScreen = Routes.HOME;
    print('User is signed in!');
  }

  print(defaultScreen);
  runApp(
    GetMaterialApp(
      title: "Application",
      /* initialBinding: ControllersBinding(), */
      //! is that ok
      initialRoute: defaultScreen,
      /* home: Routes.WALKTHROUGH, */
      /* theme: ThemeData(inputDecorationTheme: outlineInputTextFormFieldStyle),*/
      getPages: AppPages.routes,
    ),
  );
}
