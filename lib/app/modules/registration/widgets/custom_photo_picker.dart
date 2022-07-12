import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/registration/controllers/registration_controller.dart';
import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';

enum PickedType { photo, video }

class CustomPhotoPicker extends StatelessWidget {
  CustomPhotoPicker({Key? key, required this.type}) : super(key: key);

  PickedType type;

  final CameraController cameraController = Get.find<CameraController>();
  final registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    /* if(type == CustomPhotoPicker){} */
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: GestureDetector(
                onTap: () async {
                  await cameraController.getImageCamera().then((value) {
                    registrationController.uploadFile(
                        fileName: 'profile_image', directory: 'profile');
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
                await cameraController.getFileGallery().then((value) {
                  registrationController.uploadFile(
                      fileName: 'profile_image', directory: 'profile');
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
