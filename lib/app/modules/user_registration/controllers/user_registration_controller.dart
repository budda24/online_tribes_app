// Package imports:
import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/user_registration/models/country_model.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';

// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/db_services/tribe_db_services.dart';
import '../../../../infrastructure/fb_services/models/tribal_type.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/global_controler.dart';
import '../../../controllers/registration_controller.dart';
import '../../../helpers/theme/alert_styles.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camera_controller.dart';
import '../views/user_tribe_registration_choice.dart';

class ProfileRegistrationController extends GetxController {
  final loginController = Get.put(LoginController());
  final globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());
  final registrationController = Get.put(RegistrationController());

  final TextEditingController textDescribtionController =
      TextEditingController();
  final TextEditingController textLifeMottoController = TextEditingController();
  final TextEditingController textHobbyController = TextEditingController();
  /* final TextEditingController textAdressController = TextEditingController(); */
 final TextEditingController textNameController = TextEditingController();
 
 final TextEditingController textCountryController = TextEditingController();



  TribeDBServices tribeDBServices = TribeDBServices();
  UserDBServices userDBServices = UserDBServices();

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
            inputType: 'hobby', value: textHobbyController.text, lenght: 50) ||
        !globalController.validateInput(
            inputType: 'life motto',
            value: textLifeMottoController.text,
            lenght: 150) ||
        chosenTribalType == selectLabel) {
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

  
  List<Country> getSuggestions(String pattern) {
    print('getSuggestions');
    List<Country> allCountries = Country.getAllCountries() ;
    
    var suggestionCities = allCountries.where((value) {
      return value.name.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return suggestionCities;
  }

  TextEditingController textTriberersTypeController = TextEditingController();
  TextEditingController textInputDialogControler = TextEditingController();

  List<String> tribalTypes = <String>[];

  String chosenTribalType = "";
  String? selectLabel;

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
    /* chosenTribaType = textInputDialogControler.text; */
    update();
    textInputDialogControler.clear();
  }

  void assigningUser() {
    userDB.description = textDescribtionController.text;
    userDB.lifeMotto = textLifeMottoController.text;
    userDB.hobby = textHobbyController.text;
    userDB.name = textNameController.text;
    userDB.requestedTribe = chosenTribalType;
    

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

  @override
  void onInit() async {
    print('on init ProfileRegistrationController');
    tribalTypes =
        await registrationController.featchTribalTypes().then((value) {
      selectLabel = value[0];
      return value;
    });

    onClose() {
      print('onClose ProfileRegistrationController');
    }

    chosenTribalType = selectLabel!;
    super.onInit();
  }

  /* closeKeyboard() {
    globalController.unFocuseNode();
  } */
}
