import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/app_colors.dart';
import '../../registration/widgets/neumorphic_circle_background.dart';
import '../controllers/tribe_registration_controller.dart';


class TribeSignChooser extends StatelessWidget {
  final tribeRegistrationController = Get.find<TribeRegistrationController>();


  TribeSignChooser({required this.imagePath, required this.index, Key? key})
      : super(key: key);
  String imagePath;
  int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          tribeRegistrationController.choosenIndex!.value = index;
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
                child: tribeRegistrationController.choosenIndex!.value == index
                    ? NeumorphicCircleBackground(
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          radius: 15,
                          child: CircleAvatar(
                            backgroundColor: AppColors.actionColor,
                            radius: 14,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}