import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';

class RegistrationUploadVideoView extends GetView {
  final cameraController = Get.find<CameraController>();
  final registrationController = Get.find<RegistrationController>();
  final globalController = Get.find<GlobalController>();

  RegistrationUploadVideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    imageSize: 100,
                    screeanheight: 300.h,
                    screeanwidth: 250.w,
                    file: cameraController.pickedPhoto!),
              ),
              SizedBox(
                height: 40.h,
              ),
              verticalSpaceMedium,
              Obx(
                () => globalController.isLoadingVisible.value
                    ? Center(child: spinkit)
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: AppColors.whiteColor,
                        ),
                        width: double.infinity,
                        height: 460.h,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              GetBuilder<CameraController>(
                                  builder: ((cameraContr) => cameraContr
                                              .pickedVideo ==
                                          null
                                      ? Text(
                                          'Upload your intro video',
                                          style: TextStyle(fontSize: 20.sp),
                                        )
                                      : Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/profile/confirm_sign.png'),
                                            const SizedBox(width: 20),
                                            Text(
                                              'Video successfully loaded',
                                              style: TextStyle(fontSize: 20.sp),
                                            )
                                          ],
                                        ))),
                              verticalSpaceLarge,
                              GestureDetector(
                                onTap: () async {
                                  await cameraController.getVideoCamera();
                                },
                                child: Image.asset(
                                  'assets/images/authorization_screen/add_photo.png',
                                  scale: 1.3,
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await cameraController.getFileGallery(
                                      type: PickedType.video);
                                },
                                child: Image.asset(
                                  'assets/images/authorization_screen/upload_video.png',
                                  scale: 1.3,
                                ),
                              ),
                              SizedBox(
                                height: 45.h,
                              ),
                              SlimRoundedButton(
                                  backgroundColour: AppColors.primaryColor,
                                  title: 'Continue',
                                  textColor: AppColors.whiteColor,
                                  onPress: () async {
                                    registrationController.closeKeyboard();

                                    if (registrationController
                                        .checkIfVideoUpload()) {
                                      await registrationController
                                          .saveNewUser();
                                      Get.offAllNamed(Routes.PROFILE);
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
