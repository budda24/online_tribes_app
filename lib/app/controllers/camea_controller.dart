import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  File? profileIimage;

  /* File? getimage() {
    image = _pickedImage;
    update();
  } */

  Future<File?> getImageGallery() async {
    final tmpImagePath = await _picker.pickImage(source: ImageSource.gallery);
    profileIimage = File(tmpImagePath!.path);
    update();
    return profileIimage;
  }

  Future<File?> getImageCamera() async {
    final tmpImagePath = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 100,
        maxWidth: 100,
        preferredCameraDevice: CameraDevice.front);
    profileIimage = File(tmpImagePath!.path);
    update();
    return profileIimage;
  }
}
