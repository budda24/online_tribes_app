import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/camea_controller.dart';
import '../../../helpers/theme/app_colors.dart';
import '../../../helpers/theme/text_styles.dart';
import '../../../helpers/theme/ui_helpers.dart';

class CustomPhotoPicker extends StatelessWidget {
  const CustomPhotoPicker({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
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
                    await cameraController.getImageGallery();
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
                    await cameraController.getImageCamera();
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
