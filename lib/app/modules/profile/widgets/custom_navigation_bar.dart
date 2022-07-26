import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../controllers/global_controler.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/app_colors.dart';
import 'bottom_nav_bar_item.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({
    Key? key,
    required this.actualIndex,
  }) : super(key: key);

  RxInt actualIndex;
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();
    return Container(
      height: 90,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: const Border(
              top: BorderSide(
            color: Colors.black26,
            width: 2,
          ))),
      child: Obx(() => Stack(
            children: [
              Positioned(
                  left: 45,
                  top: 5,
                  child: actualIndex.value == 0
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Positioned(
                  left: 165,
                  top: 5,
                  child: actualIndex.value == 1
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Positioned(
                  right: 45,
                  top: 5,
                  child: actualIndex.value == 2
                      ? kBottomNavBarGreenMarker
                      : const SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomNavBarItem(
                      onTap: () {
                        profileController.videoController =
                            VideoViewerController();
                        actualIndex.value = 0;
                      },
                      title: 'My Profile',
                      imagePath: 'assets/images/profile/tribe.png'),
                  BottomNavBarItem(
                      onTap: () {
                        /*   profileController.videoController = null; */
                        actualIndex.value = 1;
                      },
                      title: 'Notifications',
                      imagePath: 'assets/images/profile/bell.png'),
                  BottomNavBarItem(
                      onTap: () async {
                        profileController.videoController = null;
                        actualIndex.value = 2;
                      },
                      title: 'My Tribe',
                      imagePath: 'assets/images/profile/tent.png'),
                ],
              ),
            ],
          )),
    );
  }
}
