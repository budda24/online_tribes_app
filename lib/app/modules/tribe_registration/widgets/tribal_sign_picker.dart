// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_photo_picker.dart';
import '../../registration/widgets/neumorphic_circle_background.dart';
import '../controllers/tribe_registration_controller.dart';

class TribalSignPicker extends StatelessWidget {
  final tribeRegistrationController = Get.find<TribeRegistrationController>();
  final cameraController = Get.find<CameraController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          await showModalBottomSheet(
              context: context,
              backgroundColor: AppColors.transparent,
              builder: (BuildContext context) {
                return CustomPhotoPicker();
              });
          tribeRegistrationController.customTribalSign =
              cameraController.pickedPhoto;
          tribeRegistrationController.localTribalSignPath = null;
          tribeRegistrationController.choosenSignIndex!.value = -1;
          tribeRegistrationController.update();
        },
        child: Stack(
          children: [
            GetBuilder(
              init: TribeRegistrationController(),
              builder: (controller) => SizedBox(
                height: 110.h,
                width: 80.w,
                child: tribeRegistrationController.customTribalSign != null
                    ? Stack(
                        children: [
                          SizedBox(
                            height: 110.h,
                            width: 80.w,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: Image.file(
                                      tribeRegistrationController
                                          .customTribalSign!)
                                  .image,
                            ),
                          ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: NeumorphicCircleBackground(
                                child: CircleAvatar(
                                  backgroundColor: AppColors.whiteColor,
                                  radius: 15,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.actionColor,
                                    radius: 14,
                                  ),
                                ),
                              )),
                        ],
                      )
                    : Image.asset(cAddCustomSignSign),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
