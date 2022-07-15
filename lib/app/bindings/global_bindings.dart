// Package imports:
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:get/get.dart';

// Project imports:
/* import '/app/controllers/dialog_controller.dart';
import '/app/controllers/global_controller.dart'; */

class GlobalControllersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalController>(
      () => GlobalController(),
    );

/*     Get.lazyPut<DialogController>(
      () => DialogController(),
    ); */
  }
}