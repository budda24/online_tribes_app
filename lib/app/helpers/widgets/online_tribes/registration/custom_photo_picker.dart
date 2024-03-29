import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/camera_controller.dart';

class CustomPhotoPicker extends StatelessWidget {
  CustomPhotoPicker({Key? key}) : super(key: key);

  final CameraController cameraController = Get.find<CameraController>();
  /* final registrationController = Get.find<RegistrationController>(); */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: GestureDetector(
                onTap: () async {
                  await cameraController.getImageCamera().then((value) async {
                    Get.back();
                  });
                },
                child: Image.asset(
                  'assets/images/authorization_screen/add_photo.png',
                  scale: 1.5,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await cameraController
                    .getFileGallery(type: PickedType.photo)
                    .then((value) async {
                  Get.back();
                });
              },
              child: Image.asset(
                'assets/images/authorization_screen/upload_video.png',
                scale: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
