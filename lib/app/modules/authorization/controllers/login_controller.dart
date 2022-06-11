import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../controllers/global_controler.dart';
import '../../../helpers/theme/alert_styles.dart';

class LoginController extends GetxController {
  GlobalController globalController = Get.find<GlobalController>();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController phoneController = TextEditingController();
  final TextEditingController smsCodeController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late String number;
  late String _verificationId;
  bool isVeryficationScreen = false;




  _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    Get.showSnackbar(customSnackbar(
        "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}"));
    globalController.hideLoading();
  }

  _verificationFailed(FirebaseAuthException authException) {
    Get.showSnackbar(
      customSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}'),
    );
    globalController.hideLoading();
  }

  _codeSent(String verificationId, int? forceResendingToken) async {
    _verificationId = verificationId;
    isVeryficationScreen = true;
    update();
    globalController.hideLoading();
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    return null;
  }

  Future<void> verifyPhoneNumber() async {
    globalController.showloading();
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneController.text,
          timeout: const Duration(seconds: 60),
          verificationCompleted: _verificationCompleted,
          verificationFailed: _verificationFailed,
          codeSent: _codeSent,
          codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (e) {
      globalController.hideLoading();
      throw Get.showSnackbar(customSnackbar("Firebase Exeption: $e"));
    } catch (e) {
      globalController.hideLoading();
      Get.showSnackbar(customSnackbar("Failed to Verify Phone Number: $e"));
    }
  }

  Future<void> signInWithPhoneNumber() async {
    globalController.showloading();

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCodeController.text,
    );
    try {
      await _auth.signInWithCredential(credential).then((response) {
        Get.to(() =>  RegistrationDescriptionView());

        User? _user = response.user;
        Get.snackbar('Hello', 'Welcome back ${_user!.uid}');
      });
    } on FirebaseAuthException catch (e) {
      globalController.hideLoading();
      throw Get.showSnackbar(
        customSnackbar(
          "Firebase Exeption: " + e.toString(),
        ),
      );
    } catch (e) {
      globalController.hideLoading();
      Get.showSnackbar(
        customSnackbar(
          "Failed to verify SMS code " + e.toString(),
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.off(() => LoginView());
    } on FirebaseException catch (e) {
      Get.snackbar('Firebase Error', e.code.toString());
    }
  }
}
