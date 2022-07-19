import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/custom_navigation_bar.dart';
import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileHomeView extends StatelessWidget {
  ProfileHomeView({Key? key}) : super(key: key);
  final cameraController = Get.find<CameraController>();
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar:
              CustomNavigationBar(actualIndex: profileController.actualIndex),
          body: profileController
              .bottomNavigationBarPages[profileController.actualIndex.value],
        ));
  }
}
