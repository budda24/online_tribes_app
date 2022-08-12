// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:native_device_orientation/native_device_orientation.dart';

// Project imports:
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../controllers/registration_controller.dart';
import '../widgets/time_to_invest_slider.dart';

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
        centerWidget: Column(
          children: [
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
                              '${buildController.progress} %',
                              style: headingBoldStyle,
                            ),
                          ),
                        ],
                      );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    NativeDeviceOrientationReader(builder: (context) {
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
                    });
                    /* await SystemChrome.setPreferredOrientations([
                      DeviceOrientation.landscapeRight,
                      DeviceOrientation.landscapeLeft,
                    ]); */
                    cameraController.getVideoCamera();
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
            verticalSpaceMedium,
            Stack(
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
            ),
          ],
        ),
        buttonCallBack: () async {
          registrationController.closeKeyboard();

          if (registrationController.isVideoChosen()) {
            await registrationController.saveNewUser();
          }
        },
      ),
    );
  }
}
