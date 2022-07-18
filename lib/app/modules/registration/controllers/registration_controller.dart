import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
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
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  io.File? profilePicture;

  RxDouble sliderValue = 1.0.obs;

  UserDB userDB = UserDB(
    userId: currentUser.uid,
  );

  Future<Reference?> uploadFile(
      {required String fileName,
      required String directory,
      required io.File profileFile}) async {
    //TODO cloud function to resize photo to secure the end point
    const storage = UserCloudStorageServices();

    String userId = auth.currentUser!.uid;

    return await storage.uploadFile(
        path: directory,
        userId: userId,
        imageToUpload: profileFile,
        fileName: '$fileName${extension(profileFile.path)}');
  }

  Future<void> saveNewUser() async {
    var refPhoto = await uploadFile(
        fileName: 'profileImage',
        directory: 'profile',
        profileFile: cameraController.pickedPhoto!);
    var refVideo = await uploadFile(
        fileName: 'profileVideo',
        directory: 'profile',
        profileFile: cameraController.pickedVideo!);

    userDB.introVideoUrl = await refVideo!.getDownloadURL();
    userDB.profilePhoto = await refPhoto!.getDownloadURL();
    userDB.description = describeYourselfController.text;
    userDB.lifeMotto = lifeMottoController.text;
    userDB.hobbies =
        Hobbies(hobby: hobby1Controller.text, hobby1: hobby2Controller.text);
    userDB.timeToInvest = sliderValue.value.toInt();
    userDB.email = currentUser.email;
    userDB.phoneNumber = currentUser.phoneNumber;
    print(
        'user photo : ${userDB.profilePhoto} user vide : ${userDB.introVideoUrl}');

    await UserDBServices().createUser(userDB);
  }

  bool checkIfPhotoUpload() {
    if (cameraController.pickedPhoto != null) {
      return true;
    }
    Get.showSnackbar(customSnackbar('Please chose you profile photo'));
    return false;
  }

  bool checkIfVideoUpload() {
    if (cameraController.pickedVideo != null) {
      return true;
    }
    Get.showSnackbar(customSnackbar('Please add Your introduction video'));
    return false;
  }

  String? validateUser({required String value, required int lenght}) {
    if (value.isEmpty) {
      return 'write some text';
    }
    if (value.length > lenght) {
      return 'Max message lenght = ${lenght.toString()} char';
    }
    return null;
  }

  closeKeyboard() {
    globalController.unFocuseNode();
  }






}
