import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/theme/app_colors.dart';
import 'package:flutter_application_1/app/helpers/theme/text_styles.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';

import '../../../helpers/theme/alert_styles.dart';
import '../../../controllers/global_controler.dart';

class LoginController extends GetxController {
  GlobalController globalController = Get.find<GlobalController>();

  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validateSigninForm({
    required TextEditingController email,
    required TextEditingController password,
  }) {
    /* isEmail valid */
    if (!GetUtils.isEmail(email.text)) {
      print('email : ${email.text}');
      email.clear();
      Get.showSnackbar(
        customSnackbar('Email is Invalid'),
      );
      return false;
    }
    /* isLenght < 8 */
    if (!GetUtils.isLengthGreaterThan(password.text, 8)) {
      Get.showSnackbar(
        customSnackbar('Password should contain from 8 to 16 characters'),
      );
      password.clear();
      return false;
    }
/* minimum eight characters, at least one letter and one number */
    RegExp regExpPassword = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExpPassword.hasMatch(password.text)) {
      Get.showSnackbar(
        customSnackbar(
            'Password should contain at least one letter and one number'),
      );

      password.clear();
      return false;
    } else {
      return true;
    }
  }

  /* void saveForm() async {
    formKey.currentState!.save();
    //! does that mean that the controller got saved
    print('$password  :  $email');
  } */

  Future<void> performSignin() async {
    if (validateSigninForm(
        email: phoneController, password: passwordController)) {
      final UserModel user = UserModel.fromJson({
        'email': phoneController.text,
        'name': 'Temp',
      });
      if (isRememberMe) {
        cacheUserCredencial();
      } else {
        clearUserCredencial();
      }

      await Auth().logInExistingUser(user, passwordController.text).then(
        (value) {
          globalController.isUserLogged();
        },
      );
    }
  }

  bool isRememberMe = false;
  void toggleRememberMe(bool value) {
    isRememberMe = value;
  }

  void cacheUserCredencial() {
    globalController.box.write('isRememberMe', isRememberMe);

    globalController.box.write('userCrendencial',
        {'email': phoneController.text, 'password': passwordController.text});
  }

  void clearUserCredencial() {
    globalController.box.remove('isRememberMe');
    globalController.box.remove('userCrendencial');
  }

/*   void onsaved(String ) {
    for
  } */

  /* static Rx<TextEditingController> email = TextEditingController().obs;
  static Rx<TextEditingController> password = TextEditingController().obs; */

  @override
  void onClose() {}
}
