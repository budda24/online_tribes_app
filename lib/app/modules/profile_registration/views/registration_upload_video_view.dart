// Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/main_constants.dart';
import '../../../helpers/widgets/online_tribes/registration/uploading_video.dart';
import '../controllers/profile_registration_controller.dart';

class RegistrationUploadVideoView extends GetView {
  RegistrationUploadVideoView({Key? key}) : super(key: key);

  final cameraController = Get.find<CameraController>();
  final globalController = Get.find<GlobalController>();
  /* final registrationController = Get.find<RegistrationController>(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: GetBuilder<ProfileRegistrationController>(
        builder: (builderController) => UploadingVideoView(
          
            progress: builderController.progress,
            isVideoChosen: builderController.isVideoChosen,
            availableTimeButton: () async {
              builderController.availableTime = await TimeCovertingServices()
                  .getCustomTimeRangePicker(context);
            },
            saveFunction: builderController.saveNewUser,
            switchIsVideoChosen: builderController.switchIsVideoChosen),
      ),
    );
  }
}
