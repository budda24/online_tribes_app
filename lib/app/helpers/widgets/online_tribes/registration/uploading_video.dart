import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../controllers/camera_controller.dart';
import '../../../../modules/registration/controllers/registration_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/ui_helpers.dart';
import '../general/main_button.dart';
import '../profile/profile_template.dart';

class UploadingVideoView extends StatelessWidget {
  UploadingVideoView({
    Key? key,
    required this.saveData,
    required this.profileImage,
  }) : super(key: key);

  final Function saveData;
  final Image profileImage;

  final RegistrationController registrationController =
      Get.find<RegistrationController>();
  final CameraController cameraController = Get.find<CameraController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: ProfileTemplate(
            fields: [
              verticalSpaceSmall,
              GetBuilder<RegistrationController>(
                builder: (buildController) {
                  return buildController.progress == 100.0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_rounded,
                              color: AppColors.actionColor,
                              size: 30.sp,
                            ),
                            Text(
                              'Upload Complete',
                              style: greenTitle,
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
                              backgroundColor: AppColors.primaryColor,
                              circularStrokeCap: CircularStrokeCap.round,
                              linearGradient: LinearGradient(colors: [
                                AppColors.actionColor,
                                AppColors.whiteColor,
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
              verticalSpaceExtraLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await cameraController.getVideoCamera();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/authorization_screen/add_photo.png',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await cameraController.getFileGallery(
                          type: PickedType.video);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 25),
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/authorization_screen/upload_video.png',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.129.sh,
              ),
              SlimRoundedButton(
                  backgroundColour: AppColors.primaryColor,
                  title: 'Continue',
                  textColor: AppColors.whiteColor,
                  onPress: () async {
                    registrationController.closeKeyboard();

                    if (registrationController.checkIfVideoChosen()) {
                      await saveData();
                    }
                  })
            ],
            title: const SizedBox.shrink(),
            profileVideoSrc: '',
            profileImage: profileImage),
      ),
    );
  }
}
