import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/ui_helpers.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';
import '../../../helpers/widgets/online_tribes/main_circle_photo.dart';
import '../widgets/bacground_rounded_container.dart';

class ProfileNotyficationsView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.find<ProfileController>();

  ProfileNotyficationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ProfileNotyficationsView');
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              verticalSpaceTiny,
              MainCirclePhoto.networking(
                  imageSize: 125,
                  screeanheight: 300.h,
                  screeanwidth: 250.w,
                  imagePathN: profileController.profilePhotoUrl),
              verticalSpaceSmall,
              BacgroundRoundedContainer(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Column(
                      /* children: [...profileController.notificationWidgets], */
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
