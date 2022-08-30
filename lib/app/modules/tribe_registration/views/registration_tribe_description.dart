// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

// Project imports:
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/widgets/online_tribes/registration/custom_text_field.dart';
import '../../../helpers/widgets/online_tribes/registration/registration_template.dart';
import '../controllers/tribe_registration_controller.dart';
import 'registration_tribe_aditional_info.dart';

class RegistrationTribeDescription extends GetView {
  final tribeRegistrationController = Get.put(TribeRegistrationController());
  final globalController = Get.find<GlobalController>();
  final videoController = Get.put(VideoViewerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: RegistrationTemplate(
        imagepath: tribeRegistrationController.localTribalSignPath,
        topElementsMargin: 100,
        buttonCallBack: () async {
          if (await tribeRegistrationController.validateInput(
              inputType: 'Description',
              value: tribeRegistrationController.textDescritionController.text,
              lenght: 1500)) {
            Get.to(RegistrationTribeAditionalInfo());
          }
        },
        centerWidget: CustomTextField(
          controller: tribeRegistrationController.textDescritionController,
          hintText: 'Describe purpous of your Tribe',
          maxline: 12,
          minLine: 8,
          height: 280.h,
          width: 400.w,
        ),
      ),
    );
  }
}
