// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:time_range_picker/time_range_picker.dart';

// Project imports:
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../controllers/registration_controller.dart';

class RegistrationUploadVideoView extends GetView {
  RegistrationUploadVideoView({Key? key}) : super(key: key);

  final cameraController = Get.find<CameraController>();
  final globalController = Get.find<GlobalController>();
  final registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: RegistrationTemplate(
        topElementsMargin: 50,
        centerWidget: Column(
          children: [
            GetBuilder<RegistrationController>(
                builder: (builderController) => builderController.isVideoChosen
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
                    : const SizedBox.shrink()),
            verticalSpaceTiny,
            GetBuilder<RegistrationController>(
              builder: (builderController) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 50.w,
                      lineWidth: 10.w,
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
                );
              }
            ),
            Text(
              'Chose introduction video',
              style: greenActionTitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    /* NativeDeviceOrientationReader(builder: (context) {
                      NativeDeviceOrientation orientation =
                          NativeDeviceOrientationReader.orientation(context);

                      int turns;
                      switch (orientation) {
                        case NativeDeviceOrientation.landscapeLeft:
                          turns = -1;
                          break;
                        case NativeDeviceOrientation.landscapeRight:
                          turns = 1;
                          break;
                        case NativeDeviceOrientation.portraitDown:
                          turns = 2;
                          break;
                        default:
                          turns = 0;
                          break;
                      }

                      return RotatedBox(
                          quarterTurns: turns, child: const Text('data'));
                    }); */
                    //lanscape mode but it dosen't affect the camera
                    /* await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,
                    ]); */

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
              style: greenActionTitle,
            ),
            IconButton(
              constraints: BoxConstraints(minHeight: 70.h, minWidth: 70.w),
              padding: EdgeInsets.zero,
              onPressed: () async {
                registrationController.availableTime =
                    await showTimeRangePicker(
                        interval: const Duration(hours: 1),
                        minDuration: const Duration(hours: 1),
                        use24HourFormat: false,
                        padding: 30,
                        strokeWidth: 20,
                        handlerRadius: 14,
                        strokeColor: AppColors.actionColor,
                        handlerColor: AppColors.actionColor.withOpacity(0.7),
                        selectedColor: AppColors.actionColor,
                        backgroundColor: AppColors.primaryColor,
                        ticks: 12,
                        ticksColor: AppColors.actionColor,
                        snap: true,
                        context: context,
                        timeTextStyle: tribalFontLable,
                        activeTimeTextStyle: tribalFontLableWhite);
                /* print(result.endTime.hour); */ //int
                /* print(DateTime.now().timeZoneName.runtimeType); */
              },
              icon: Container(
                height: 200.h,
                width: 200.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                ),
                child: Icon(
                  Icons.access_alarms,
                  size: 50.h,
                  color: AppColors.blackColor,
                ),
              ),
            )
            /* Stack(
              children: [
                const Positioned(
                    top: 65,
                    left: 100,
                    child: Text(
                      'Time to invest',
                      style: kHintStyle,
                    )),
                TimeToInvestSlider(
                    sliderValue: registrationController.sliderValue),
              ],
            ), */
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
      ),
    );
  }
}
