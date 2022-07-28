//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/camea_controller.dart';

import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../helpers/widgets/online_tribes/profile/profile_template.dart';
import '../controllers/profile_controller.dart';
import '../widgets/notification_list.dart';

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
          fields:  [NotificationList()],
          title: const SizedBox.shrink(),
          videoSrc: '',
          profileImage: Image.network(profileController.profilePhotoUrl),
        )),
      ),
    );
  }
}
