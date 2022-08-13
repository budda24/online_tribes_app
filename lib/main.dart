// Package imports:
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/bindings/global_bindings.dart';
import 'package:cloud_functions/cloud_functions.dart';

// Project imports:
import 'app/controllers/global_controler.dart';
import 'app/helpers/theme/app_colors.dart';
import 'app/modules/authorization/controllers/login_controller.dart';
import 'app/modules/authorization/views/login_view.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/walkthrough/controllers/walkthrough_controller.dart';
import 'app/modules/walkthrough/views/walkthrough_view.dart';
import 'app/routes/app_pages.dart';

/* List<CameraDescription> cameras = []; */

Future<void> _configureFirebaseStorage() async {
  String configHost = const String.fromEnvironment("FIREBASE_EMU_URL");
  int configPort = const int.fromEnvironment("STORAGE_EMU_PORT");
  // Android emulator must be pointed to 10.0.2.2
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  var host = configHost.isNotEmpty ? configHost : defaultHost;
  var port = configPort != 0 ? configPort : 9199;
  await FirebaseStorage.instance.useStorageEmulator(host, port);
  debugPrint('Using Firebase Storage emulator on: $host:$port');
}

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

void _configureFirebaseFunction() {
  var defaultHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFunctions functions = FirebaseFunctions.instance;
  functions.useFunctionsEmulator(defaultHost, 5001);

  debugPrint('Using Firebase Function emulator on: $defaultHost:5001');
}

bool connectToFirebaseEmulator = true;
void main() async {
  Get.put(GlobalController());
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
    _configureFirebaseFunction();
    await _configureFirebaseStorage();
  }

  /* try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  } */

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var defaultRout = Routes.LOGIN;
  Widget defaultScreen = LoginView();
  void choseInitialScreen() {
    final globalController = Get.find<GlobalController>();
    Get.put(WalkthroughController());
    Get.put(LoginController());
    /*if visited set home to loginscree  */
    if (globalController.box.read('isWalkthroughDone') != null &&
        globalController.box.read('isWalkthroughDone')) {
      defaultRout = Routes.LOGIN;
      defaultScreen = LoginView();
    } else {
      defaultRout = Routes.WALKTHROUGH;
      defaultScreen = WalkthroughView();
    }

    if (FirebaseAuth.instance.currentUser == null) {
      defaultRout = Routes.LOGIN;
      defaultScreen = LoginView();
    } else {
      defaultRout = Routes.HOME;
      defaultScreen = HomeScreen();
      //Todo after login go to profile screen
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO run to implement walthrough
    //initialize defaultScreenRout & defaultScreen
    //choseInitialScreen();

    return LayoutBuilder(
      builder: (context, constraints) => MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
        child: ScreenUtilInit(
          designSize: const Size(360,
              690) /* ScreenSizes(constraints: constraints).getScreenSize() */,
          minTextAdapt: true,
          builder: (context, child) => GetMaterialApp(
            /* theme: ThemeData(
                inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
            )), */
            initialBinding: GlobalControllersBinding(),
            title: "Application",
            getPages: AppPages.routes,
            home: AnimatedSplashScreen(
              splashIconSize: 300,
              duration: 1000,
              splash: 'assets/splash_screen/splash_screen.gif',
              /* nextRoute: defaultRout, */
              nextScreen: defaultScreen,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: AppColors.primaryColor,

            ),

            initialRoute: defaultRout,
            defaultTransition: Transition.fadeIn,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
