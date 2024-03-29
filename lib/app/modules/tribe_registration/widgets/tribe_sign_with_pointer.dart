// Package imports:

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../helpers/theme/app_colors.dart';
import '../../user_registration/widgets/neumorphic_circle_background.dart';
import '../controllers/tribe_registration_controller.dart';

class TribeSignWithPointer extends StatelessWidget {
  final tribeRegistrationController = Get.find<TribeRegistrationController>();
  final cameraController = Get.find<CameraController>();

  TribeSignWithPointer({required this.imagePath, required this.index, Key? key})
      : super(key: key);
  String imagePath;
  int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          tribeRegistrationController.choosenSignIndex!.value = index;
          tribeRegistrationController.customTribalSign = null;
          tribeRegistrationController.localTribalSignPath = imagePath;
          tribeRegistrationController.isSignChosen.value = true;
          tribeRegistrationController.update();
        },
        child: Stack(
          children: [
            SizedBox(
              height: 110.h,
              width: 80.w,
              child: Image.asset(imagePath),
            ),
            Obx(
              () => Positioned(
                top: 0,
                right: 0,
                child:
                    tribeRegistrationController.choosenSignIndex!.value == index
                        ? NeumorphicCircleBackground(
                            child: CircleAvatar(
                              backgroundColor: AppColors.white,
                              radius: 15,
                              child: CircleAvatar(
                                backgroundColor: AppColors.actionColor,
                                radius: 14,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
