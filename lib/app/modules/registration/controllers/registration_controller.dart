// Package imports:
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/user_cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camera_controller.dart';
import '../views/tribe_registration_choice.dart';

class RegistrationController extends GetxController {
  final loginController = Get.put(LoginController());
  final globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());

  final TextEditingController describtionController = TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  io.File? profilePicture;

  RxDouble sliderValue = 1.0.obs;

  UserDB userDB = UserDB(
    userId: currentUser.uid,
  );

  double progress = 0.0;

  Future<UploadTask> uploadFile(
      {required String fileName,
      required String directory,
      required io.File profileFile}) {
    //TODO cloud function to resize photo to secure the end point
    final storage = UserCloudStorageServices();

    String userId = auth.currentUser!.uid;

    return Future.value(
      storage.uploadFile(
          path: directory,
          userId: userId,
          imageToUpload: profileFile,
          fileName: '$fileName${extension(profileFile.path)}'),
    );
  }

  var videoUploaded = false.obs;

  Future<void> saveNewUser() async {
    globalController.showloading();
    await uploadFile(
            fileName: 'profileImage',
            directory: 'profile',
            profileFile: cameraController.pickedPhoto!)
        .then((taskSnapshot) => taskSnapshot.then((upladTask) async {
              var url = await upladTask.ref.getDownloadURL();
              var metaDataRef = await upladTask.ref.getMetadata();
              var metaData = Metadata(
                  bucket: metaDataRef.bucket,
                  name: metaDataRef.name,
                  size: metaDataRef.size!,
                  fullPath: metaDataRef.fullPath,
                  contentType: metaDataRef.contentType!,
                  timeCreated: metaDataRef.timeCreated,
                  contentEncoding: metaDataRef.contentEncoding);

              userDB.profilePhoto =
                  UploadedFile(downloadUrl: url, metaData: metaData);

            }));

    await uploadFile(
            fileName: 'profileVideo',
            directory: 'profile',
            profileFile: cameraController.pickedVideo!)
        .then((uploadTask) => uploadTask.snapshotEvents.listen((event) async {
              if (event.state == TaskState.running) {
                progress = ((event.bytesTransferred.toDouble() /
                            event.totalBytes.toDouble()) *
                        100)
                    .roundToDouble();

                update();
              }
              if (event.state == TaskState.success) {
              var url = await event.ref.getDownloadURL();
              var metaDataRef = await event.ref.getMetadata();
              var metaData = Metadata(
                  bucket: metaDataRef.bucket,
                  name: metaDataRef.name,
                  size: metaDataRef.size!,
                  fullPath: metaDataRef.fullPath,
                  contentType: metaDataRef.contentType!,
                  timeCreated: metaDataRef.timeCreated,
                  contentEncoding: metaDataRef.contentEncoding);

              userDB.introVideo =
                  UploadedFile(downloadUrl: url, metaData: metaData);
                  for (var i = 0; i < 20; i++) {
                    await UserDBServices().createUser(userDB);
                  }


                videoUploaded.value = true;
                Get.to(TribeRegistrationChoice());

              }
            }));

    userDB.description = describtionController.text;
    userDB.lifeMotto = lifeMottoController.text;
    userDB.hobbies =
        Hobbies(hobby: hobby1Controller.text, hobby1: hobby2Controller.text);
    userDB.timeToInvest = sliderValue.value.toInt();
    userDB.email = currentUser.email;
    userDB.phoneNumber = currentUser.phoneNumber;

    await globalController.saveRegistrationState();
  }

  bool checkIfPhotoUpload() {
    if (cameraController.pickedPhoto != null) {
      return true;
    }
    Get.showSnackbar(customSnackbar('Please chose you profile photo'));
    return false;
  }

  bool isVideoChosen() {
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
