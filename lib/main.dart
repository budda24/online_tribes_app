
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/modules/authorization/controllers/login_controller.dart';
import 'package:cloud_functions/cloud_functions.dart';



import 'app/controllers/global_controler.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_application_1/app/modules/walkthrough/controllers/walkthrough_controller.dart';


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
  /* FirebaseFirestore.instance.useFirestoreEmulator(host, port); */
  debugPrint('Using Firebase Firestore emulator on: $host:$port');
}
void _configureFirebaseFunction(){
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFunctions functions = FirebaseFunctions.instance;
        functions.useFunctionsEmulator(defaultHost, 5001);
}


bool connectToFirebaseEmulator = true;
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();
  if (connectToFirebaseEmulator) {
    await _configureFirebaseAuth();
    _configureFirebaseFirestore();
    /*  _connectToFirebaseEmulator(); */
  }

  /* try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  } */

  final controller = Get.put(GlobalController());
  Get.put(WalkthroughController());
  Get.put(LoginController());

  var defaultScreen = Routes.LOGIN;
  /*if visited set home to loginscree  */
  if (Get.find<GlobalController>().box.read('isWalkthroughDone') != null &&
      Get.find<GlobalController>().box.read('isWalkthroughDone')) {
    defaultScreen = Routes.LOGIN;
  } else {
    defaultScreen = Routes.WALKTHROUGH;
  }
  if (FirebaseAuth.instance.currentUser == null) {
    defaultScreen = Routes.LOGIN;
  } else {
    defaultScreen = Routes.HOME; //Todo after login go to profile screen
  }

  runApp(MyApp()
      /* GetMaterialApp(
      title: "Application",
      initialBinding: ControllersBinding(),
      initialRoute: Routes.LOGIN,

      /* home: Routes.HOME, */
      /* theme: ThemeData(inputDecorationTheme: outlineInputTextFormFieldStyle),*/
      // getPages: AppPages.routes,
    ), */
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController());
    return LayoutBuilder(
      builder: (context, constraints) => MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: ScreenUtilInit(
          designSize: const Size(360,
              690) /* ScreenSizes(constraints: constraints).getScreenSize() */,
          minTextAdapt: true,
          builder: (context, child) => GetMaterialApp(
            title: "Application",
            getPages: AppPages.routes,
            initialRoute: Routes.LOGIN,
            defaultTransition: Transition.fadeIn,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
