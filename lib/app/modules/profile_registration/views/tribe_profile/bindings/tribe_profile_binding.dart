import 'package:get/get.dart';

import '../controllers/tribe_profile_controller.dart';

class TribeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TribeProfileController(),
    );
  }
}
