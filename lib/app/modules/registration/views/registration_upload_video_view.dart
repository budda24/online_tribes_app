// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Project imports:
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../../../helpers/widgets/online_tribes/registration/time_range_button.dart';
import '../../../helpers/widgets/online_tribes/registration/uploading_video.dart';
import '../controllers/registration_controller.dart';

class RegistrationUploadVideoView extends GetView {
  RegistrationUploadVideoView({Key? key}) : super(key: key);

  final cameraController = Get.find<CameraController>();
  final globalController = Get.find<GlobalController>();
  /* final registrationController = Get.find<RegistrationController>(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: GetBuilder<RegistrationController>(
          builder: (builderController) => UploadingVideoView(
              saveData: builderController.saveNewUser,
              /* profileImage: cameraController.pickedPhoto, */
              progress: builderController.progress,
              isVideoChosen: builderController.isVideoChosen,
              availableTimeButton: () async {
                builderController.availableTime =
                    await TimeCovertingServices()
                        .getCustomTimeRangePicker(context);
              },
              saveFunction: builderController.saveNewUser,
              switchIsVideoChosen: builderController.switchIsVideoCosen)

          /* RegistrationTemplate(
          showButton: builderController.progress != 0.0 ? false : true,
          topElementsMargin: 50,
          centerWidget: Column(
            children: [
              builderController.isVideoChosen &&
                      builderController.progress == 0.0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_rounded,
                          color: AppColors.actionColor,
                          size: 30.sp,
                        ),
                        Text(
                          'Video is chosen',
                          style: greenActionTitle,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              verticalSpaceSmall,
              builderController.progress == 0.0
                  ? const SizedBox.shrink()
                  : Container(
                      height: 300,
                      margin: const EdgeInsets.only(top: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 100.w,
                            lineWidth: 20.w,
                            percent: builderController.progress / 100,
                            backgroundColor: AppColors.primaryColor,
                            circularStrokeCap: CircularStrokeCap.round,
                            linearGradient: LinearGradient(colors: [
                              AppColors.primaryColor,
                              AppColors.actionColor,
                            ]),
                            rotateLinearGradient: true,
                            animation: true,
                            animateFromLastPercent: true,
                            animationDuration: 2000,
                            curve: Curves.bounceIn,
                            widgetIndicator: Image.asset(
                              'assets/images/authorization_screen/logo/50x50.png',
                            ),
                            center: Text(
                              '${builderController.progress} %',
                              style: headingBoldStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
              verticalSpaceTiny,
              builderController.progress == 0.0
                  ? Container(
                      child: Column(
                        children: [
                          Text(
                            'Chose introduction video',
                            style: greenTitle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await cameraController.getVideoCamera();
                                  if (cameraController.pickedVideo != null) {
                                    registrationController.switchIsVideoCosen();
                                  }
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
                                  if (cameraController.pickedVideo != null) {
                                    registrationController.switchIsVideoCosen();
                                  }
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
                          verticalSpaceMedium,
                          Text(
                            'Available time for meeting',
                            style: greenTitle,
                          ),
                          AvailableTimeButton(onPressed: () async {
                            registrationController.availableTime =
                                await TimeCovertingServices()
                                    .getCustomTimeRangePicker(context);
                          })
                        ],
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          buttonCallBack: () async {
            registrationController.closeKeyboard();

            if (registrationController.isVideoChosen) {
              await registrationController.saveNewUser();
            } else {
              Get.showSnackbar(
                  customSnackbar('Please add Your introduction video'));
            }
          },
        ), */
          ),
    );
  }
}
