import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../../../infrastructure/fb_services/cloud_storage/user_cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camea_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();
  final globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());

  final TextEditingController describeYourselfController =
      TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  io.File? profilePicture;

  RxDouble sliderValue = 1.0.obs;

  UserDB userDB = UserDB(
    userId: currentUser.uid,
  );

  uploadFile({required String fileName, required String directory}) {
    //TODO cloud function to resize photo to secure the end point
    const storage = UserCloudStorageServices();
    String userId = auth.currentUser!.uid;
    var profilePhoto = cameraController.pickedFile!;
    storage.uploadFile(
        path: directory,
        userId: userId,
        imageToUpload: profilePhoto,
        fileName: '$fileName${extension(profilePhoto.path)}');
  }

  String? userDBValidator({required String value, required int lenght}) {
    if (value.isEmpty) {
      return 'write some text';
    }
    if (value.length > lenght) {
      return 'Max message lenght = ${lenght.toString()} char';
    }
    return null;
  }

  Future<void> saveNewUser() async {
    userDB.description = describeYourselfController.text;
    userDB.lifeMotto = lifeMottoController.text;
    userDB.hobby = hobbyController.text;
    userDB.timeToInvest = sliderValue.value.toInt();
    userDB.email = currentUser.email;
    userDB.phoneNumber = currentUser.phoneNumber;
    userDB.introVideoUrl = 'Test test http';

    await UserDBServices().createUser(userDB);
  }


  closeKeyboard() {
    globalController.unFocuseNode();
  }
}
