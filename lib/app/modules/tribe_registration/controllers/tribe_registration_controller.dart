// Package imports:

import 'dart:async';
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/tribe_db_services.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
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
import '../../../../infrastructure/fb_services/models/user_model.dart' as user;
import '../../../helpers/theme/main_constants.dart';

class TribeRegistrationController extends GetxController {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textTriberersTypeController = TextEditingController();
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
  UserDBServices userDBServices = UserDBServices();

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
    tribeDB.triberersType = textTriberersTypeController.text;
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

  var videoUploaded = false.obs;
  double progress = 0.0;

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
    required Future Function(Reference) getRefrence,
    Future Function(TribeDb)? functionAfterUploaded,
    bool recordingTheProgress = false,
  }) async {
    //TODO cloud function to resize photo to secure the end point
    final storage = CloudStorageServices();
    String userId = auth.currentUser!.uid;
    return storage
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
        var ref = event.ref;
        await getRefrence(ref);
        if (functionAfterUploaded != null) {
          await functionAfterUploaded(tribeDB);
        }
      }
    });
  }

  Future<void> saveNewTribe() async {
    if (isTimeChosen()) {
      assignTribeDb();

      if (customTribalSign != null) {
        await uploadFile(
            getRefrence: (ref) async {
              print('get ref custom tribal sign');
              tribeDB.customTribalSign = await getRef(ref);
            },
            fileName: 'tribeImage',
            directory: 'profile',
            profileFile: customTribalSign!);
      } else {
        tribeDB.localTribalSign = localTribalSignPath;
      }
      await uploadFile(
              functionAfterUploaded: tribeDBServices.createTribe,
              recordingTheProgress: true,
              getRefrence: (ref) async {
                tribeDB.tribalIntroVideo = await getRef(ref);
              },
              fileName: 'tribalVideo',
              directory: 'profile',
              profileFile: cameraController.pickedVideo!)
          .then((value) async {});
      /* await globalController.saveRegistrationState(); */
      //TODO SAVE registration state

    }
  }

  assignigTriberers() {}
/////////////////////////
  ///
  ///
  TextEditingController searchTextEditingController = TextEditingController();
  List<user.UserDB> usersList = [];
  List<user.UserDB> temporaryUsersList = [];
  List<user.UserDB> invitedUsersList = [];

  final ScrollController scrollController = ScrollController();
  final usersSnapshot = <DocumentSnapshot>[];
  int limit = 6;
  bool hasMore = true;
  bool isFetchingUsers = false;
  String alreadySearched = '';

  Future<void> fetchNextUsers() async {
    if (isFetchingUsers) return;
    isFetchingUsers = true;
    var snapshot = await UserDBServices().fetchLimitedUsers(
        limit: limit,
        startAfter: usersSnapshot.isNotEmpty ? usersSnapshot.last : null);

    usersSnapshot.addAll(snapshot.docs);
    if (snapshot.docs.length < limit) hasMore = false;

    final newUsers = List<user.UserDB>.from(
        snapshot.docs.map((e) => user.UserDB.fromJson(e.data())).toList());

    usersList.addAll(newUsers);

    update();

    isFetchingUsers = false;
  }

  updateInvidedUsersList(user.UserDB user) {
    if (invitedUsersList.length == 5 || user.isInvited == false) {
      invitedUsersList.removeWhere((e) => e.phoneNumber == user.phoneNumber);
      return;
    } else {
      invitedUsersList.add(user);
    }
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (hasMore) {
        fetchNextUsers();
      }
    }
  }

  rebuildWidget() {
    update();
  }

  Future<void> searchByEmailOrPhone() async {
    if (searchTextEditingController.text.isEmpty ||
        alreadySearched == searchTextEditingController.text) {
      return;
    }

    alreadySearched = searchTextEditingController.text;

    if (searchTextEditingController.text.characters.contains('@')) {
      var user = await UserDBServices()
          .feachUserByEmail(email: searchTextEditingController.text);
      if (user.isNotEmpty) {
        if (temporaryUsersList.isEmpty) temporaryUsersList = usersList;
        usersList = user;
        update();
      }
      return;
    } else {
      var user = await userDBServices.feachUserByPhoneNumber(
          phoneNumber: searchTextEditingController.text);
      if (user.isNotEmpty) {
        if (temporaryUsersList.isEmpty) temporaryUsersList = usersList;
        usersList = user;
        print(usersList.length);
        update();
      }
      return;
    }
  }

  showAllUsersAgain() async {
    if (temporaryUsersList.isEmpty) return;

    usersList.clear();
    update();
    await Future.delayed(const Duration(milliseconds: 500));
    usersList.addAll(temporaryUsersList);
    temporaryUsersList.clear();
    update();
  }

  @override
  void onInit() async {
    tribalTypes = await featchTribalTypes().then((value) => value);
    chosenTribaType = tribalTypes.toList()[0];
    scrollController.addListener(scrollListener);
    await fetchNextUsers();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
