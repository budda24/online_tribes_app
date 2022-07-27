//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camea_controller.dart';
import '../../../helpers/theme/app_colors.dart';
import '../controllers/profile_controller.dart';
import '../widgets/custom_navigation_bar.dart';
import 'profile_info_view.dart';
import 'profile_my_tribe_view.dart';
import 'profile_notyfications_view.dart';

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
