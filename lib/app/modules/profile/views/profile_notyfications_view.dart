import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/profile/profile_template.dart';
import 'package:flutter_application_1/app/modules/profile/controllers/profile_controller.dart';

import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/main_constants.dart';

class ProfileNotyficationsView extends GetView {
  final cameraController = Get.find<CameraController>();
  final profileController = Get.find<ProfileController>();

  ProfileNotyficationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: SafeArea(
            child: ProfileTemplate(
          fields: const [/* profileController.notificationWidgets */],
          title: const SizedBox.shrink(),
          videoSrc: '',
          profileImage: Image.network(profileController.profilePhotoUrl),
        )),
      ),
    );
  }
}
