import 'dart:io';

import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  /* final globalController = Get.find<GlobalController>(); */

  File? pickedFile;

  /* File? getimage() {
    image = _pickedImage;
    update();
  } */

  Future<void> getFileGallery() async {
    final tmpImagePath = await _picker.pickImage(source: ImageSource.gallery);
    pickedFile = File(tmpImagePath!.path);
    update();
    Get.back();
  }

  Future<void> getImageCamera() async {
    final tmpImagePath = await _picker.pickImage(
        maxHeight: 100,
        maxWidth: 100,
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front);
    pickedFile = File(tmpImagePath!.path);
    update();
    Get.back();
  }

  Future<void> getVideoCamera() async {
    final tmpImagePath = await _picker.pickVideo(
        maxDuration: const Duration(minutes: 3),
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front);
    pickedFile = File(tmpImagePath!.path);
    update();
    Get.back();
  }
}
