import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../controllers/global_controler.dart';

class LoginController extends GetxController {
  GlobalController globalController = Get.find<GlobalController>();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();

  PhoneNumber? numberToVerify;
  RxBool isVeryficationScreen = false.obs;
  final _auth = Auth();
  Future<void> verifyPhoneNumber() async {
    isVeryficationScreen.value = true;
    await _auth.verifyPhoneNumber(numberToVerify!.phoneNumber!);
  }

  Future<void> signInWithPhoneNumber() async {
    final error = await _auth.signInWithPhoneNumber(smsCodeController.text);
    if (error != null) {
      smsCodeController.clear();
    }
  }

  Future<void> signInWithGoogle() async {
    await Auth().signInWithGoogle();
  }

  logout() {

    _auth.logout();
  }
}
