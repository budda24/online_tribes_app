import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';

enum PickedType { photo, video }

class CustomPhotoPicker extends StatelessWidget {
  CustomPhotoPicker({Key? key, required this.type}) : super(key: key);

  final CameraController cameraController = Get.find<CameraController>();

  PickedType type;

  @override
  Widget build(BuildContext context) {
    /* if(type == CustomPhotoPicker){} */
    return Card(
      color: AppColors.textFieldFill,
      child: Container(
        height: 100,
        color: AppColors.textFieldFill,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (type == PickedType.photo) {
                      await cameraController.getFileGallery();
                    } else {
                      cameraController.getVideoCamera();
                    }
                  },
                  icon: Icon(
                    Icons.photo_album,
                    size: 50.h,
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  '   Gallery',
                  style: headingBoldStyle,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    await cameraController.getFileGallery();
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 50.h,
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  '   Camera',
                  style: headingBoldStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
