import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

import 'app/bindings/global_bindings.dart';
import 'app/controllers/global_controler.dart';
/* import 'app/helpers/theme/form_field_styles.dart';
import 'app/modules/authorization/controllers/login_controller.dart'; */
import 'app/routes/app_pages.dart';
import 'package:flutter_application_1/app/modules/walkthrough/controllers/walkthrough_controller.dart';
/* import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';

import 'package:flutter_application_1/app/modules/walkthrough/views/walkthrough_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart'; */

/* List<CameraDescription> cameras = []; */
/* Future _connectToFirebaseEmulator() async {
  final localHostString = GetPlatform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.settings = Settings(
      host: '$localHostString:8080',
      sslEnabled: false,
      persistenceEnabled: false);

  FirebaseAuth.instance.useAuthEmulator('http://localhost', 9099);
  debugPrint('Using firebbase Auth emulator on: ');

  /* await FirebaseAuth.instance.useAuthEmulator('http://$localHostString', 9099); */
}
 */

Future<void> _configureFirebaseAuth() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("AUTH_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9099;
  await FirebaseAuth.instance.useAuthEmulator(host, port);
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);
  debugPrint('Using Firebase Auth emulator on: $host:$port');
}

/* Future<void> _configureFirebaseStorage() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("STORAGE_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9199;
  await FirebaseStorage.instance.useStorageEmulator(host, port);
  debugPrint('Using Firebase Storage emulator on: $host:$port');
} */

void _configureFirebaseFirestore() {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("DB_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 8080;

  FirebaseFirestore.instance.settings = Settings(
    host: '$host:$port',
    sslEnabled: false,
    persistenceEnabled: false,
  );
  debugPrint('Using Firebase Firestore emulator on: $host:$port');
}

bool connectToFirebaseEmulator = true;
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (connectToFirebaseEmulator) {
   await _configureFirebaseAuth();
    /* await _connectToFirebaseEmulator(); */
  }

  /* try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  } */

  final controller = Get.put(GlobalController());
  Get.put(WalkthroughController());

  var defaultScreen = Routes.LOGIN;
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
  } else {
    defaultScreen = Routes.HOME; //Todo after login go to profile screen
    print(' 2 else $defaultScreen');
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      initialBinding: ControllersBinding(),
      initialRoute: Routes.LOGIN,

      /* home: Routes.HOME, */
      /* theme: ThemeData(inputDecorationTheme: outlineInputTextFormFieldStyle),*/
      getPages: AppPages.routes,
    ),
  );
}
