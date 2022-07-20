import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_info_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_my_tribe_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_notyfications_view.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/custom_navigation_bar.dart';
import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileHomeView extends GetView {
  ProfileHomeView({Key? key}) : super(key: key);
  // final cameraController = Get.find<CameraController>();
  final profileController = Get.put(ProfileController());
  final cameraController = Get.put(CameraController());

  List<Widget> bottomNavigationBarPages = [
    ProfileInfoView(),
    ProfileNotyficationsView(),
    ProfileMyTribeView()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.primaryColor,
          bottomNavigationBar:
              CustomNavigationBar(actualIndex: profileController.actualIndex),
          body: bottomNavigationBarPages[profileController.actualIndex.value],
        ));
  }
}
