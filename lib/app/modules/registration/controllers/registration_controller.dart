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
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../authorization/controllers/login_controller.dart';
import '../../../controllers/camea_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();
  final cameraController = Get.put(CameraController());

  /* GlobalKey<FormState> formKey = GlobalKey(); */

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


  final TextEditingController describeYourselfController =
      TextEditingController();

  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  UserDB userDB = UserDB(
    userId: currentUser.uid,
  );

  Future<void> saveNewUser() async {
    await UserDBServices().createUser(userDB);
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

  closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onClose() {}
}
