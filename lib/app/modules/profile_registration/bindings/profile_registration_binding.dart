import 'package:get/get.dart';

import '../controllers/profile_registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRegistrationController>(
      () => ProfileRegistrationController(),
    );
  }
}
