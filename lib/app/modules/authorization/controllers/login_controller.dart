import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';

import '../../../helpers/controllers/global_controller.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RxString? password = ''.obs;
  RxString? email = ''.obs;

  bool validateSignupForm() {
    if (!GetUtils.isEmail(emailController.text)) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: 'Email is INvalid',
      ));
      return false;
    } else {
      return true;
    }
  }

  Future<void> performSignin() async {
    if (validateSignupForm()) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
        'name': 'Temp',
      });
      await Auth().logInExistingUser(user, passwordController.text);
    }
  }

  Future<void> performSignup() async {
    if (validateSignupForm()) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
        'name': 'Temp',
      });
      await Auth().createUserToAuth(user, passwordController.text);
    }
  }

  void saveForm() async {
    formKey.currentState!.save();
    print('$password  :  $email');
  }

/*   void onsaved(String ) {
    for
  } */

  /* static Rx<TextEditingController> email = TextEditingController().obs;
  static Rx<TextEditingController> password = TextEditingController().obs; */

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
