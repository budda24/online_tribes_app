import 'dart:io' as io;

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../../../../infrastructure/fb_services/cloud_storage/user_cloud_storage_services.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camea_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();
  final cameraController = Get.put(CameraController());


  final signUpTribalNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final smsCodeController = TextEditingController();
  final signUpPasswordConfirmController = TextEditingController();

  RxDouble sliderValue = 1.0.obs;
  final auth = FirebaseAuth.instance;
  String verificationID = '';
  bool isSMSCodeHere = false;
  bool isLoadingVisible = false;

  io.File? profilePicture;

  uploadProfilePicture() {
    const storage = UserCloudStorageServices();
    String userId = auth.currentUser!.uid;

    var profilePhoto = cameraController.profileIimage!;
    storage.uploadProfileImage(
        userId: userId,
        imageToUpload: profilePhoto,
        fileName: 'profile_picture${extension(profilePhoto.path)}');
  }

  showloading() {
    isLoadingVisible = true;
  }

  turnOffLoading() {
    isLoadingVisible = false;
  }

  Future<void> verifySMSCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCodeController.text);

    showloading();

    try {
      await auth.signInWithCredential(credential).then((response) {
        if (response.user != null) {
          Get.to(() => RegistrationDescriptionView());
        }
      });

      turnOffLoading();
    } on FirebaseException catch (e) {
      turnOffLoading();

      Get.snackbar('Firebase Error', e.code.toString());
    }
  }

  //TODO fix the register moved to auth
  Future<void> registerUserByPhone({
    required String mobileNumber,
  }) async {

  }
  // Future<void> createUser() async {
  //   if (validateSignupForm(
  //       password: signUpPasswordController,
  //       confirmPassword: signUpPasswordConfirmController,
  //       tribalName: signUpTribalNameController,
  //       email: signUpPhoneController)) {
  //     print('create user validation: ${signUpPhoneController.text}');
  //     Map<String, Object> userModelJson = {
  //       'email': signUpPhoneController.text,
  //       'name': signUpTribalNameController.text,
  //     };
  //     final UserModel user = UserModel.fromJson(userModelJson);
  //     await Auth().createUserToAuth(user, signUpPasswordController.text);
  //   }
  // }

  Rx<double> range = 5.0.obs; //again initialized it to a Rx<double>

  void setRange(double range) {
    this.range.value = range; //updating the value of Rx Variable.
  }

  static List<String> hobbies = []; //list of given values hobbies

  static void addHobby(String value) {
    hobbies.add(value); //add hobby given value
  }

  RxList<Widget> hobbiesFields = [
    //list of hobby textField widgets
    Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: CustomTextField(
        controller: RegistrationController._hobbyController1,
        height: 45,
        width: 500,
        hintText: 'Hobbies',
        maxline: 1,
        minLine: 1,
        onSave: (value) {
          addHobby(value);
        },
      ),
    ),
  ].obs;

  static final _hobbyController1 = TextEditingController();
  static final _hobbyController2 = TextEditingController();
  static final _hobbyController3 = TextEditingController();
  static final _hobbyController4 = TextEditingController();
  static final _hobbyController5 = TextEditingController();
  // hobby textField controllers stored in a List for creating textFields with controllers
  List<TextEditingController> hobbyControllers = [
    _hobbyController1,
    _hobbyController2,
    _hobbyController3,
    _hobbyController4,
    _hobbyController5
  ];
//index for itterating true hobby controllers
  int _index = 2;
  //add new texFormField for hobbies TextFields
  void addHobbyField() {
    if (hobbiesFields.length >= 4) {
      return;
    }
    hobbiesFields.add(
      Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: CustomTextField(
          controller: hobbyControllers[_index],
          height: 45,
          width: 500,
          hintText: 'Hobbies $_index',
          maxline: 1,
          minLine: 1,
          onSave: (value) {
            addHobby(value);
          },
        ),
      ),
    );
    _index++;
  }

  @override
  void onClose() {}
}
