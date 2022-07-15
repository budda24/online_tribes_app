import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class ProfileNotyficationsView extends GetView {
  final cameraController = Get.find<CameraController>();
  final registrationController = Get.find<RegistrationController>();

  ProfileNotyficationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
                top: BorderSide(
              color: AppColors.greyColor,
              width: 3,
            ))),
        child: Obx(() => Stack(
              children: [
                Positioned(
                    left: 45,
                    child: registrationController.actualIndex.value == 1
                        ? registrationController.elipseAssets
                        : const SizedBox()),
                Positioned(
                    left: 165,
                    child: registrationController.actualIndex.value == 2
                        ? registrationController.elipseAssets
                        : const SizedBox()),
                Positioned(
                    right: 45,
                    child: registrationController.actualIndex.value == 3
                        ? registrationController.elipseAssets
                        : const SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomNavBarItem(
                        onTap: () {
                          registrationController.actualIndex.value = 1;
                        },
                        title: 'My Profile',
                        imagePath: 'assets/images/profile/tribe.png'),
                    BottomNavBarItem(
                        onTap: () {
                          registrationController.actualIndex.value = 2;
                        },
                        title: 'Notifications',
                        imagePath: 'assets/images/profile/bell.png'),
                    BottomNavBarItem(
                        onTap: () {
                          registrationController.actualIndex.value = 3;
                        },
                        title: 'My Tribe',
                        imagePath: 'assets/images/profile/tent.png'),
                  ],
                ),
              ],
            )),
      ),
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              NeumorphicCircleBackground(
                child: MainCirclePhoto.file(
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    file: cameraController.pickedPhoto!),
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  String title;
  String imagePath;
  VoidCallback onTap;

  BottomNavBarItem({
    required this.title,
    required this.imagePath,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SizedBox(
              height: 35,
              width: 35,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
