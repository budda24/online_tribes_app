// Package imports:

import 'dart:async';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/tribe_db_services.dart';
import 'package:flutter_application_1/infrastructure/native_functions/time_converting_services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/models/tribal_type.dart';
import '../../../../infrastructure/fb_services/models/tribe_model.dart';
import '../../../helpers/theme/main_constants.dart';

class TribeRegistrationController extends GetxController {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textPurpousController = TextEditingController();
  TextEditingController textDescritionController = TextEditingController();

  TextEditingController textInputDialogControler = TextEditingController();

  var globalController = Get.find<GlobalController>();
  var cameraController = Get.find<CameraController>();

  RxInt? choosenSignIndex = (-1).obs;
  RxBool isSignChosen = false.obs;
  bool isVideoChosen = false;
  String? localTribalSignPath;
  io.File? customTribalSign;

  TribeDBServices tribeDBServices = TribeDBServices();

  String chosenTribaType = "";
  List<String> tribalTypes = <String>[];

  addTypeName() async {
    if (!tribalTypes.contains(textInputDialogControler.text.capitalize)) {
      tribalTypes.add(textInputDialogControler.text.capitalize!);
      tribeDBServices
          .updateListTribalTypes(TribalType(types: tribalTypes.toList()));
    } else {
      Get.showSnackbar(customSnackbar('type already exist'));
    }
    //TODO chose the added sign
    /* chosenTribaType = textInputDialogControler.text; */
    update();
    textInputDialogControler.clear();
  }

  List<Map<String, dynamic>> tribesSigns = [
    {'imagePath': cMotheringTribeSign, 'index': 0},
    {'imagePath': cMusicalTribeSign, 'index': 1},
    {'imagePath': cTravellerTribeSign, 'index': 2},
    {'imagePath': cArtistTribeSign, 'index': 3},
    {'imagePath': cBussinessTribeSign, 'index': 4},
    {'imagePath': cWriteringTribeSign, 'index': 5},
    {'imagePath': cIllnessTribeSign, 'index': 6},
  ];

  var tribeDB = TribeDb(tribeId: const Uuid().v1());

  Future<UploadedFile> getRef(Reference ref) async {
    var url = await ref.getDownloadURL();
    var metaDataRef = await ref.getMetadata();

    var metaData = Metadata(
        bucket: metaDataRef.bucket,
        name: metaDataRef.name,
        size: metaDataRef.size!,
        fullPath: metaDataRef.fullPath,
        contentType: metaDataRef.contentType!,
        timeCreated: metaDataRef.timeCreated,
        contentEncoding: metaDataRef.contentEncoding);

    return UploadedFile(downloadUrl: url, metaData: metaData);
  }

  listenToProgress(TaskSnapshot event) {
    if (event.state == TaskState.running) {
      progress =
          ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();
      update();
    }
  }

  Future uploadFile({
    required String fileName,
    required String directory,
    required io.File profileFile,
    required Future Function(Reference ref) getRefrence,
    bool recordingTheProgress = false,
  }) async {
    //TODO cloud function to resize photo to secure the end point
    final storage = CloudStorageServices();
    String userId = auth.currentUser!.uid;
    storage
        .uploadFile(
            folder: "Tribes",
            path: directory,
            userId: userId,
            imageToUpload: profileFile,
            fileName: '$fileName${extension(profileFile.path)}')
        .snapshotEvents
        .listen((event) async {
      if (recordingTheProgress) {
        listenToProgress(event);
      }
      if (event.state == TaskState.success) {
        await getRef(event.ref);
      }
    });
  }

  AvailableTime createAvailableTime() {
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOffset = DateTime.now().timeZoneOffset.inHours;
    return AvailableTime(
        endZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.endTime.hour, offset: timeZoneOffset),
        startZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.startTime.hour, offset: timeZoneOffset),
        timeZone: timeZone,
        start: availableTime!.startTime.hour,
        end: availableTime!.endTime.hour);
  }

  assignTribeDb() {
    tribeDB.description = textDescritionController.text;
    tribeDB.tribalName = textNameController.text;
    tribeDB.availableTime = createAvailableTime();
    tribeDB.type = chosenTribaType;
  }

  TimeRange? availableTime;
  bool isTimeChosen() {
    if (availableTime != null) {
      return true;
    } else {
      Get.showSnackbar(customSnackbar('Available time not chosen'));
      return false;
    }
  }

  var videoUploaded = false.obs;
  double progress = 0.0;

  Future<void> saveNewTribe() async {
    if (isTimeChosen()) {
      assignTribeDb();

      if (customTribalSign != null) {
        await uploadFile(
            getRefrence: (ref) async {
              tribeDB.customTribalSign = await getRef(ref);
            },
            fileName: 'tribeImage',
            directory: 'profile',
            profileFile: customTribalSign!);
      } else {
        tribeDB.localTribalSign = localTribalSignPath;
      }
      await uploadFile(
              recordingTheProgress: true,
              getRefrence: (ref) async {
                tribeDB.tribalIntroVideo = await getRef(ref);
              },
              fileName: 'tribalVideo',
              directory: 'profile',
              profileFile: cameraController.pickedVideo!)
          .then((value) async {
        await tribeDBServices.createTribe(tribeDB);
      });
      /* await globalController.saveRegistrationState(); */
      //TODO SAVE registration state

    }
  }

  void switchIsVideoChosen() {
    isVideoChosen = !isVideoChosen;
    update();
  }

  Future<bool> validateInput(
      {required String value, required int lenght, required inputType}) async {
    if (value.isEmpty) {
      globalController
          .showErrror('You have to put something in $inputType !!!');

      return false;
    }
    if (value.length > lenght) {
      globalController.showErrror(
          'in $inputType Max message lenght = ${lenght.toString()} char');

      return false;
    }
    return true;
  }

  Future<List<String>> featchTribalTypes() async {
    var tribalTypes = await tribeDBServices.fechListTribalTypes();
    List<String> typesList = [];
    if (tribalTypes != null) {
      for (var element in tribalTypes.types) {
        typesList.add(element);
      }
    }
    return typesList;
  }

  assignigTriberers() {}
  //TODO assign triberers to a tribe
  @override
  void onInit() async {
    tribalTypes = await featchTribalTypes().then((value) => value);
    chosenTribaType = tribalTypes.toList()[0];
    super.onInit();
  }
}
