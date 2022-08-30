import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/registration/registration_template.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../controllers/camera_controller.dart';
import '../../../theme/alert_styles.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../../theme/ui_helpers.dart';
import 'time_range_button.dart';

class UploadingVideoView extends StatelessWidget {
  UploadingVideoView({
    Key? key,
    required this.saveData,
    required this.progress,
    required this.isVideoChosen,
    required this.availableTimeButton,
    required this.saveFunction,
    required this.switchIsVideoChosen,
    this.imagePath,
  }) : super(key: key);

  final VoidCallback saveData;

  final double progress;
  final bool isVideoChosen;
  final Function switchIsVideoChosen;
  final Future Function() availableTimeButton;
  final Future Function() saveFunction;
  final String? imagePath;

  final cameraController = Get.find<CameraController>();
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplate(
      imagepath: imagePath,
      showButton: progress != 0.0 ? false : true,
      topElementsMargin: 50,
      centerWidget: Column(
        children: [
          isVideoChosen && progress == 0.0
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
          progress == 0.0
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
                        percent: progress / 100,
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
                          '$progress %',
                          style: headingBoldStyle,
                        ),
                      ),
                    ],
                  ),
                ),
          verticalSpaceTiny,
          progress == 0.0
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
                                switchIsVideoChosen();
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
                                switchIsVideoChosen();
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
                      verticalSpaceExtraLarge,
                      Text(
                        'Available time for meeting',
                        style: greenTitle,
                      ),
                      AvailableTimeButton(
                          onPressed: () async => await availableTimeButton())
                    ],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
      buttonCallBack: () async {
        globalController.unFocuseNode();

        if (isVideoChosen) {
          await saveFunction();
        } else {
          Get.showSnackbar(
              customSnackbar('Please add Your introduction video'));
        }
      },
    );
  }
}
