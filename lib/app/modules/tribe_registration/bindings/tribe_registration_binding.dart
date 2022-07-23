import 'package:get/get.dart';

import '../controllers/tribe_registration_controller.dart';

class TribeRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TribeRegistrationController>(
      () => TribeRegistrationController(),
    );
  }
}
