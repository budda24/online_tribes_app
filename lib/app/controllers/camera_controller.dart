import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

enum PickedType { photo, video }

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  /* final globalController = Get.find<GlobalController>(); */

  File? pickedPhoto;
  File? pickedVideo;

  PickedType pickedType = PickedType.photo;

  clearPickedPhotoAndVideo() {
    pickedPhoto = null;
    pickedVideo = null;
  }

  Future<void> getFileGallery({required PickedType type}) async {
    XFile? tmpFilePath;
    switch (type) {
      case PickedType.photo:
        tmpFilePath = await _picker.pickImage(source: ImageSource.gallery);

        break;
      case PickedType.video:
        tmpFilePath = await _picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(minutes: 3));
        break;
    }

    if (type == PickedType.photo) {
      pickedPhoto = File(tmpFilePath!.path);
      update();
    } else {
      pickedVideo = File(tmpFilePath!.path);
      update();
    }
  }

  Future<void> getImageCamera() async {
    final tmpImagePath = await _picker.pickImage(
        maxHeight: 100,
        maxWidth: 100,
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front);
    pickedPhoto = File(tmpImagePath!.path);
    update();
  }

  Future<void> getVideoCamera() async {
    final tmpImagePath = await _picker.pickVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxDuration: const Duration(minutes: 3),
    );

    pickedVideo = File(tmpImagePath!.path);
    //portait mode
    /* await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);  */
    update();
  }
}
