//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../controllers/global_controler.dart';

class LoginController extends GetxController {
  GlobalController globalController = Get.find<GlobalController>();
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();

  PhoneNumber? numberToVerify;
  RxBool isVeryficationScreen = false.obs;
  final _auth = Auth();
  late final String? boxPhonNumber;

  void writeNumberToBox() {
    globalController.box.write('phoneNumber', numberToVerify!.phoneNumber);
    globalController.box.write('dialCode', numberToVerify!.dialCode);
    globalController.box.write('isoCode', numberToVerify!.isoCode);
  }

  void removeNumberfromBox() {
    globalController.box.remove('phoneNumber');
    globalController.box.remove('dialCode');
    globalController.box.remove('isoCode');
  }

  Future<void> verifyPhoneNumber() async {
    isVeryficationScreen.value = true;

    await _auth.verifyPhoneNumber(numberToVerify!.phoneNumber!);

    //check if attemting to register new number
    if (boxPhonNumber != numberToVerify!.phoneNumber) {
      print('write box number');
      removeNumberfromBox();
      writeNumberToBox();
    }
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

  PhoneNumber readBoxPhoneNumber() {
    var phoneNumber = globalController.box.read('phoneNumber');
    var dialCode = globalController.box.read('dialCode');
    var isoCode = globalController.box.read('isoCode');

    return PhoneNumber(
        dialCode: dialCode, isoCode: isoCode, phoneNumber: phoneNumber);
  }

  @override
  void onInit() async {
    boxPhonNumber = globalController.box.read('phoneNumber');

    if (boxPhonNumber != null) {
      numberToVerify = readBoxPhoneNumber();
    }

    /* print('erese');
    globalController.box.erase(); */
    super.onInit();
  }

  logout() {
    _auth.logout();
  }
}
