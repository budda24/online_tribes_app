import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_aditional_info_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:flutter_application_1/app/modules/walkthrough/controllers/walkthrough_controller.dart';
import 'package:flutter_application_1/app/modules/walkthrough/views/walkthrough_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/global_bindings.dart';
import 'app/controllers/global_controler.dart';
import 'app/helpers/theme/form_field_styles.dart';
import 'app/modules/authorization/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';

/* List<CameraDescription> cameras = []; */
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /* try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  } */

  final controller = Get.put(GlobalController());
  /* init waltrough controler writing the is visited to the global box */
  Get.put(WalkthroughController());
  Get.put(LoginController());

  var defaultScreen = Routes.LOGIN;
/*
  /*if visited set home to loginscree  */
  if (Get.find<GlobalController>().box.read('isWalkthroughDone') != null &&
      Get.find<GlobalController>().box.read('isWalkthroughDone')) {
    defaultScreen = Routes.LOGIN;
  } else {
    defaultScreen = Routes.WALKTHROUGH;
  }
  if (FirebaseAuth.instance.currentUser == null) {
    /* print(2); */
    defaultScreen = Routes.LOGIN;
  }/*  else {
    defaultScreen = Routes.HOME; //Todo after login go to profile screen
    print(' 2 else');
  } */

 */
  runApp(
    GetMaterialApp(
      title: "Application",
      /* initialBinding: ControllersBinding(), */
      //! is that ok
      /*   initialRoute: defaultScreen,
 */
      /*   home: Routes.WALKTHROUGH, */
      home: RegistrationDescriptionView(),
      /* theme: ThemeData(inputDecorationTheme: outlineInputTextFormFieldStyle),*/
      // getPages: AppPages.routes,
    ),
  );
}
