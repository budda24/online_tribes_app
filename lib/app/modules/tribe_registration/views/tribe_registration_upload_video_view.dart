// Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/modules/tribe_registration/controllers/tribe_registration_controller.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../helpers/widgets/online_tribes/registration/uploading_video.dart';

class RegistrationTribeUploadVideoView extends GetView {
  var tribeRegistrationController = Get.find<TribeRegistrationController>();
  var cameraController = Get.find<CameraController>();
  @override
  Widget build(BuildContext context) {
    tribeRegistrationController.progress = 0.0;
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: GetBuilder<TribeRegistrationController>(
          builder: (builderControler) => UploadingVideoView(
              imagePath: builderControler.localTribalSignPath,
              progress: tribeRegistrationController.progress,
              isVideoChosen: tribeRegistrationController.isVideoChosen,
              availableTimeButton: () async {
                builderControler.availableTime = await TimeCovertingServices()
                    .getCustomTimeRangePicker(context);
              },
              saveFunction: tribeRegistrationController.saveNewTribe,
              switchIsVideoChosen:
                  tribeRegistrationController.switchIsVideoChosen),
        ));
  }
}
