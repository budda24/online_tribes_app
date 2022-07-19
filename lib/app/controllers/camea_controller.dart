import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

enum PickedType { photo, video }

class CameraController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  /* final globalController = Get.find<GlobalController>(); */

  File? pickedPhoto;
  File? pickedVideo;

  PickedType pickedType = PickedType.photo;

  Future<void> getFileGallery({required PickedType type}) async {
    XFile? tmpImagePath;
    switch (type) {
      case PickedType.photo:
        print('picked photo');
        tmpImagePath = await _picker.pickImage(source: ImageSource.gallery);

        break;
      case PickedType.video:
        print('picked video');
        tmpImagePath = await _picker.pickVideo(source: ImageSource.gallery);
        break;
    }

    if (type == PickedType.photo) {
      print('assign photo');
      pickedPhoto = File(tmpImagePath!.path);
      update();
    } else {
      print('assign video');
      pickedVideo = File(tmpImagePath!.path);
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
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    pickedVideo = File(tmpImagePath!.path);
    update();
  }
}
