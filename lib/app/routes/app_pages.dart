import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_aditional_info_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_basic_info.dart';
import 'package:get/get.dart';

import '../modules/authorization/bindings/login_binding.dart';
import '../modules/authorization/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/walkthrough/bindings/walkthrough_binding.dart';
import '../modules/walkthrough/views/walkthrough_view.dart';
import '../modules/registration/views/registration_user_view.dart';

// Flutter imports:

// Package imports:

// Project imports:

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WALKTHROUGH;

  static final routes = [
    //Todo Home screen implementation
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationBasicInfoView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.WALKTHROUGH,
      page: () => WalkthroughView(),
      binding: WalkthroughBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

  ];
}
