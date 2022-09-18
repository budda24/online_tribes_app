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
import '../../../../infrastructure/fb_services/models/user_model.dart'
    as userClass;
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

  String chosenTribalType = "";
  List<String> tribalTypes = <String>[];

  addTypeName() async {
    if (tribalTypes.contains(textInputDialogControler.text.capitalize)) {
      Get.showSnackbar(customSnackbar('type already exist'));
    } else {
      tribalTypes.add(textInputDialogControler.text.capitalize!);
      chosenTribalType = tribalTypes[tribalTypes.length - 1];
      await tribeDBServices
          .updateListTribalTypes(TribalType(types: tribalTypes))
          .onError((error, stackTrace) {
        tribalTypes.removeLast();
        chosenTribalType = tribalTypes[tribalTypes.length - 1];
      });
    }
    //TODO chose the added sign
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
    tribeDB.type = chosenTribalType;
  }

  TimeRange? availableTime;

  void switchIsVideoChosen() {
    isVideoChosen = !isVideoChosen;
    update();
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
  int numberOfInitialFetchUsers = 6;
  bool moreUserExist = true;
  List<userClass.UserDB> displayedUsersList = [];
  List<userClass.UserDB> invitedUserList = [];

  Future<void> fetchUsers() async {
    var fetchedUsers =
        await userDBServices.fetchUsersFromDB(limit: numberOfInitialFetchUsers);
    if (fetchedUsers.length == displayedUsersList.length) {
      moreUserExist = false;
    } else {
      displayedUsersList = await userDBServices.fetchUsersFromDB(
          limit: numberOfInitialFetchUsers);
    }
    update();
  }

  removeUserInvitationFromList(userClass.UserDB user) {
    invitedUserList.removeWhere((invitedUser) {
      if (invitedUser.phoneNumber == user.phoneNumber) {
        invitedUser.isInvited = false;
        return true;
      }
      return false;
    });
  }

  addUserInvitationToList(userClass.UserDB user) {
    user.isInvited = true;
    invitedUserList.add(user);
  }

  Future<bool> removeInvitationFromDb({
    required userClass.UserDB user,
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
    required userClass.UserDB userToHandle,
    required String tribeId,
  }) async {
    if (await userDBServices.sendInvitationToUser(
        invitedUserID: userToHandle.userId, senderTribeId: tribeId)) {
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
      userClass.UserDB userToHandle, String invitationTribeId) async {
    //TODO DB invitation??
    if (isMaxInvitation() || userToHandle.isInvited) {
      removeUserInvitationFromList(userToHandle);
    } else {
      addUserInvitationToList(userToHandle);
    }
    update();
  }

  Future<int> sendInviteNotyficationToUsers() async {
    var succeedeInvitationCounter = 0;
    for (var i = 0; i < invitedUserList.length; i++) {
      if (await userDBServices.sendInvitationToUser(
          invitedUserID: invitedUserList[i].userId,
          senderTribeId: auth.currentUser!.uid)) {
        succeedeInvitationCounter++;
      }
    }
    return succeedeInvitationCounter;
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      numberOfInitialFetchUsers += maxInvitation;
      fetchUsers();
      update();
    }
  }

  //TODO refactor the searchByEmailOrPhone nested if's

  bool isSearchingUser = false;
  TextEditingController searchTextEditingController = TextEditingController();
  Future<List<userClass.UserDB>> getSearchedUser(String searchedBy) async {
    if (GetUtils.isEmail(searchedBy)) {
      return await userDBServices.fetchUserByEmail(email: searchedBy);
    } else if (GetUtils.isPhoneNumber(searchedBy)) {
      return await userDBServices.fetchUserByPhoneNumber(
          phoneNumber: searchedBy);
    }
    return [];
  }

  _actionNotFoud() {
    searchTextEditingController.clear();
    globalController
        .showErrror("No user found\n Please corect the search try again");
  }

  Future<void> searchByEmailOrPhone() async {
    displayedUsersList =
        await getSearchedUser(searchTextEditingController.text);
    if (displayedUsersList.isEmpty) {
      _actionNotFoud();
    }
    isSearchingUser = true;

    update();
  }

  listenIfSeartchTextEmpty() {
    if (searchTextEditingController.text.isNotEmpty) {
    } else {}
    update();
  }

  Future<void> showAllUsersAgain() async {
    isSearchingUser = false;
    await fetchUsers();
    update();
  }

  @override
  void onInit() async {
    tribalTypes = await registrationController.featchTribalTypes();
    chosenTribalType = tribalTypes.toList()[0];
    scrollController.addListener(scrollListener);
    searchTextEditingController.addListener(listenIfSeartchTextEmpty);
    //TODO name of te func ??
    await fetchUsers();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
