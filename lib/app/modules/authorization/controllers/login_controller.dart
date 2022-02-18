import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RxString? password = ''.obs;
  RxString? email = ''.obs;

  bool validateSignupForm() {
    /* isEmail valid */
    if (!GetUtils.isEmail(emailController.text)) {
      emailController.clear();
      Get.showSnackbar(
        customSnackbar('Email is Invalid'),
      );
      return false;
    }
    /* isLenght < 8 */
    if (!GetUtils.isLengthGreaterThan(passwordController.text, 8)) {
      Get.showSnackbar(
        customSnackbar('Password should contain from 8 to 16 characters'),
      );
      passwordController.clear();
      return false;
    }

/* minimum eight characters, at least one letter and one number */
    RegExp regExp = RegExp(
      r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExp.hasMatch(passwordController.text)) {
      Get.showSnackbar(
        customSnackbar(
            'Password should contain at least one letter and one number'),
      );

      passwordController.clear();
      return false;
    } else {
      return true;
    }
  }

  void saveForm() async {
    formKey.currentState!.save();
    print('$password  :  $email');
  }

  Future<void> performSignin() async {
    if (validateSignupForm()) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
        'name': 'Temp',
      });
      if (isRememberMe) {
        cacheUserCredencial();
      } else {
        clearUserCredencial();
      }
      await Auth()
          .logInExistingUser(user, passwordController.text)
          .then((value) {
        globalController.isUserLogged();
      }).catchError((onError) {
        Get.showSnackbar(customSnackbar(onError.toString()));
      });
    }
  }

  Future<void> performSignup() async {
    if (validateSignupForm()) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
        'name': 'Temp',
      });
      await Auth()
          .createUserToAuth(user, passwordController.text)
          .then((value) {
        /* globalController.isUserLogged(); */
      }).catchError((onError) {
        Get.showSnackbar(customSnackbar(onError.toString()));
      });
    }
  }

  bool isRememberMe = false;
  void toggleRememberMe(bool value) {
    isRememberMe = value;
  }

  void cacheUserCredencial() {
    globalController.box.write('isRememberMe', isRememberMe);

    globalController.box.write('userCrendencial',
        {'email': emailController.text, 'password': passwordController.text});
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
  void onInit() {
    /* if (globalController.box.read('userCrendencial') !=
            null /*  &&
        globalController.box.read('userCrendencial') */
        ) {
      emailController.text =
          globalController.box.read('userCrendencial')['email'];
      passwordController.text =
          globalController.box.read('userCrendencial')['password'];
    }
    if (globalController.box.read('isRememberMe') !=
            null /* &&
        Get.find<GlobalController>().box.read('isWalkthroughDone') */
        ) {
      isRememberMe = globalController.box.read('isRememberMe');
    } */

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
