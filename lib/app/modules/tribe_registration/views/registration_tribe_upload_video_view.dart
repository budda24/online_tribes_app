import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../helpers/widgets/online_tribes/registration/uploading_video.dart';

class RegistrationTribeUploadVideoView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: UploadingVideoView(
            saveData: () {

            },
            profileImage: Image.asset(
                'assets/images/authorization_screen/logo/xxxhdpi.png')));
  }
}
