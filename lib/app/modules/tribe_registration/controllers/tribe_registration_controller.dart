// Package imports:

import 'dart:async';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';

import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../../../../infrastructure/fb_services/db_services/tribe_db_services.dart';
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/tribal_type.dart';
import '../../../../infrastructure/fb_services/models/tribe_model.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart' as user;
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/camera_controller.dart';
import '../../../controllers/global_controler.dart';
import '../../../controllers/registration_controller.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../../helpers/theme/main_constants.dart';
import '../views/invite_new_tribe_member.dart';

class TribeRegistrationController extends GetxController {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textTriberersTypeController = TextEditingController();
  TextEditingController textDescritionController = TextEditingController();

  TextEditingController textInputDialogControler = TextEditingController();

  var globalController = Get.find<GlobalController>();
  var cameraController = Get.find<CameraController>();
  var registrationController = Get.put(RegistrationController());

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

  void switchIsVideoChosen() {
    isVideoChosen = !isVideoChosen;
    update();
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

  double progress = 0.0;
  listenToProgress(TaskSnapshot event) {
    if (event.state == TaskState.running) {
      progress =
          ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();
      update();
    }
  }

  Future<void> saveNewTribe() async {
    if (!registrationController.isTimeChosen(availableTime)) {
      return;
    } else {
      assignTribeDb();
      if (customTribalSign != null) {
        await registrationController.uploadFile(
            getRefrence: (ref) async {
              tribeDB.customTribalSign =
                  await registrationController.getRef(ref);
            },
            fileName: 'tribeImage',
            directory: 'profile',
            profileFile: customTribalSign!);
      } else {
        tribeDB.localTribalSign = localTribalSignPath;
      }
      await registrationController.uploadFile(
        functionAfterUploaded: () async {
          await tribeDBServices.createTribe(tribeDB);
        },
        fileName: 'tribalVideo',
        directory: 'profile',
        profileFile: cameraController.pickedVideo!,
        listenToProgress: (event) async {
          if (event.state == TaskState.running) {
            progress = ((event.bytesTransferred.toDouble() /
                        event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();

            update();
          }
        },
        getRefrence: (ref) async {
          tribeDB.tribalIntroVideo = await registrationController.getRef(ref);
        },
      );
      Get.to(InviteTribeMember());
    }
  }

  assignigTriberers() {}

  final ScrollController scrollController = ScrollController();

  int limit = 6;
  bool moreUserExist = true;
  String alreadySearched = '';
  TextEditingController searchTextEditingController = TextEditingController();
  List<user.UserDB> displayedUsersList = [];
  List<user.UserDB> invitedUserList = [];

  Future<void> fetchUsers() async {
    var feachedUsers = await userDBServices.fetchUsersFromDB(limit: limit);
    if (feachedUsers.length == displayedUsersList.length) {
      moreUserExist = false;
    } else {
      displayedUsersList = await userDBServices.fetchUsersFromDB(limit: limit);
    }
  }

  removeUserInvitationFromList(user.UserDB user) {
    invitedUserList.removeWhere((invitedUser) {
      if (invitedUser.phoneNumber == user.phoneNumber) {
        invitedUser.isInvited = false;
        return true;
      }
      return false;
    });
  }

  addUserInvitationToList(user.UserDB user) {
    user.isInvited = true;
    invitedUserList.add(user);
  }

  Future<bool> removeInvitationFromDb({
    required user.UserDB user,
    required String tribeId,
  }) async {
    if (await userDBServices.deleteInvitationUser(
      invitedUserID: user.userId,
      tribeId: tribeId,
    )) {
      return true;
    }
    return false;
  }

  Future<bool> addInvitationToDb({
    required user.UserDB userToHandle,
    required String tribeId,
  }) async {
    if (await userDBServices.sendInvitationToUser(
        invitedUserID: userToHandle.userId, tribeId: tribeId)) {
      invitedUserList.add(userToHandle);
      return true;
    }
    return false;
  }

  final maxInvitation = 5;
  bool isMaxInvitation() {
    if (invitedUserList.length == maxInvitation) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateInvitationUsersList(
      user.UserDB userToHandle, String invitationTribeId) async {
    //TODO DB invitation??
    if (isMaxInvitation() || userToHandle.isInvited) {
      removeUserInvitationFromList(userToHandle);
    } else {
      addUserInvitationToList(userToHandle);
    }
    update();
  }

  Future<int> sendInviteNotyficationToUsers() async {
    //TODO counter how many invitation   send
    var succeedeInvitationCounter = 0;
    for (var i = 0; i < invitedUserList.length; i++) {
      if (await userDBServices.sendInvitationToUser(
          invitedUserID: invitedUserList[i].userId,
          tribeId: auth.currentUser!.uid)) {
        succeedeInvitationCounter++;
      }
    }
    return succeedeInvitationCounter;
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      limit += maxInvitation;
      fetchUsers();
      update();
    }
  }

/*   rebuildWidget() {
    update();
  } */

  //TODO refactor the searchByEmailOrPhone nested if's

  /* Future<void> searchByEmailOrPhone() async {
    if (searchTextEditingController.text.isEmpty ||
        alreadySearched == searchTextEditingController.text) {
      return;
    }

    alreadySearched = searchTextEditingController.text;

    if (GetUtils.isEmail(searchTextEditingController.text)) {
      var user = await UserDBServices()
          .feachUserByEmail(email: searchTextEditingController.text);
      if (user.isNotEmpty) {
        temporaryUsersList.isEmpty ? displayedUsersList : temporaryUsersList;
        displayedUsersList = user;
        update();
      }
      return;
    } else {
      var user = await userDBServices.feachUserByPhoneNumber(
          phoneNumber: searchTextEditingController.text);
      if (user.isNotEmpty) {
        if (temporaryUsersList.isEmpty) temporaryUsersList = displayedUsersList;
        displayedUsersList = user;

        update();
      }
      return;
    }
  }

  showAllUsersAgain() async {
    if (temporaryUsersList.isEmpty) return;

    displayedUsersList.clear();
    update();
    await Future.delayed(const Duration(milliseconds: 500));
    displayedUsersList.addAll(temporaryUsersList);
    temporaryUsersList.clear();
    update();
  } */

  @override
  void onInit() async {
    tribalTypes = await featchTribalTypes();
    chosenTribaType = tribalTypes.toList()[0];
    scrollController.addListener(scrollListener);
    //TODO name of te func ??
    await fetchUsers();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
