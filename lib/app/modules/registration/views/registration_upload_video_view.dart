import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/main_button.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/modules/registration/widgets/neumorphic_circle_background.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/widgets/online_tribes/profile/main_circle_photo.dart';
import 'tribe_registration_start.dart';

class RegistrationUploadVideoView extends GetView {
  RegistrationUploadVideoView({Key? key}) : super(key: key);

  final cameraController = Get.find<CameraController>();
  final globalController = Get.find<GlobalController>();
  final registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              GetBuilder<RegistrationController>(
                builder: (buildController) {
                  return buildController.progress == 100.0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_rounded,
                              color: AppColors.actionColor,
                              size: 50.sp,
                            ),
                            SizedBox(
                              width: 5.0.w,
                            ),
                            Text(
                              'Upload Complete',
                              style: GoogleFonts.poppins(
                                  color: AppColors.actionColor,
                                  fontSize: 30.sp),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 70,
                              lineWidth: 20,
                              percent: buildController.progress / 100,
                              backgroundColor: AppColors.whiteColor,
                              circularStrokeCap: CircularStrokeCap.round,
                              linearGradient: LinearGradient(colors: [
                                AppColors.actionColor,
                                AppColors.primaryColor,
                              ]),
                              rotateLinearGradient: true,
                              animation: true,
                              animateFromLastPercent: true,
                              animationDuration: 20,
                              curve: Curves.bounceIn,
                              widgetIndicator: Image.asset(
                                'assets/images/authorization_screen/logo/50x50.png',
                              ),
                              center: Text(
                                '${buildController.progress} %',
                                style: headingBoldStyle,
                              ),
                            ),
                          ],
                        );
                },
              ),
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
                  await cameraController.getFileGallery(type: PickedType.video);
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

                    if (registrationController.checkIfVideoUpload()) {
                      await registrationController
                          .saveNewUser()
                          .then((value) => Get.off(TribeRegistrationChoice()));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
