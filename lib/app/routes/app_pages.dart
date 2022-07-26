import 'package:flutter_application_1/app/modules/profile/views/profile_home_view.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/views/registration_tribe_choose_sign.dart';
import 'package:get/get.dart';

import '../modules/authorization/bindings/login_binding.dart';
import '../modules/authorization/views/login_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';

import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_desrription_view.dart';
import '../modules/tribe_registration/views/tribe_registration_start.dart';
import '../modules/walkthrough/bindings/walkthrough_binding.dart';
import '../modules/walkthrough/views/walkthrough_view.dart';

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
      page: () => RegistrationDescriptionView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.WALKTHROUGH,
      page: () => WalkthroughView(),
      binding: WalkthroughBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileHomeView(),
      binding: ProfileBinding(),
    ),
  ];
}
