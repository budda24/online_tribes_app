// Package imports:
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';

// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/global_controler.dart';
import '../../../controllers/registration_controller.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camera_controller.dart';
import '../views/tribe_registration_choice.dart';

class ProfileRegistrationController extends GetxController {
  final loginController = Get.put(LoginController());
  final globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());
  final registrationController = Get.put(RegistrationController());

  final TextEditingController describtionController = TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();

  io.File? profilePicture;

  TimeRange? availableTime;

  UserDB userDB = UserDB(
    profileNotification: [],
    userId: currentUser.uid,
    isInvited: false,
  );

  bool isVideoChosen = false;

  bool validateAditionalInfo() {
    if (!globalController.validateInput(
            inputType: 'hobby', value: hobby2Controller.text, lenght: 50) ||
        !globalController.validateInput(
            inputType: 'hobby', value: hobby1Controller.text, lenght: 50) ||
        !globalController.validateInput(
            inputType: 'life motto',
            value: lifeMottoController.text,
            lenght: 150)) {
      return false;
    } else {
      return true;
    }
  }

  bool checkIfPhotoChosen() {
    if (cameraController.pickedPhoto != null) {
      return true;
    }
    globalController.showErrror('Please chose you profile photo');
    return false;
  }

  void switchIsVideoChosen() {
    isVideoChosen = !isVideoChosen;
    update();
  }

  void assigningUser() {
    userDB.description = describtionController.text;
    userDB.lifeMotto = lifeMottoController.text;
    userDB.hobbies =
        Hobbies(hobby: hobby1Controller.text, hobby1: hobby2Controller.text);

    userDB.createdAt = FieldValue.serverTimestamp();

    var timeZoneOffset = DateTime.now().timeZoneOffset.inHours;
    userDB.availableTime = AvailableTime(
        endZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.endTime.hour, offset: timeZoneOffset),
        startZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.startTime.hour, offset: timeZoneOffset),
        timeZone: DateTime.now().timeZoneName,
        start: availableTime!.startTime.hour,
        end: availableTime!.endTime.hour);

    userDB.email = currentUser.email;
    userDB.phoneNumber = currentUser.phoneNumber;
  }

  var videoUploaded = false.obs;
  double progress = 0.0;

  Future<void> saveNewUser() async {
    if (registrationController.isTimeChosen(availableTime)) {
      globalController.showloading();
      await registrationController.uploadFile(
          getRefrence: (ref) async {
            userDB.profilePhotoRef = await registrationController.getRef(ref);
          },
          fileName: 'profileImage',
          directory: 'profile',
          profileFile: cameraController.pickedPhoto!);

      await registrationController.uploadFile(
        fileName: 'profileVideo',
        directory: 'profile',
        profileFile: cameraController.pickedVideo!,
        getRefrence: (ref) async {
          userDB.introVideoRef = await registrationController.getRef(ref);
        },
        listenToProgress: (event) async {
          if (event.state == TaskState.running) {
            progress = ((event.bytesTransferred.toDouble() /
                        event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();

            update();
          }
          if (event.state == TaskState.success) {
            await globalController.saveRegistrationState();
            globalController.hideLoading();
            videoUploaded.value = true;
            Get.to(const TribeRegistrationChoice());
          }
        },
        functionAfterUploaded: () async {
          assigningUser();
          await globalController.saveRegistrationState();

          globalController.hideLoading();

          await UserDBServices().createManyUsers(userDB, 5);
          /* await UserDBServices().createUser(userDB); */

          videoUploaded.value = true;

          Get.to(const TribeRegistrationChoice());
        },
      );
    }
  }

  /* closeKeyboard() {
    globalController.unFocuseNode();
  } */
}