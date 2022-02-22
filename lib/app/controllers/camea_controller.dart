import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

import '../../main.dart';

class CameraGetXController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  File? image;
  /* File? getimage() {
    image = _pickedImage;
    update();
  } */

  Future<XFile?> getImageGallery() async {
    final tmpImagePath = await _picker.pickImage(source: ImageSource.gallery);
    image = File(tmpImagePath!.path);
    update();
  }

  Future<XFile?> getImageCamera() async {
    final tmpImagePath = await _picker.pickImage(source: ImageSource.camera, maxHeight: 100, maxWidth: 100,preferredCameraDevice: CameraDevice.front);
    image = File(tmpImagePath!.path);
    update();
  }
}
