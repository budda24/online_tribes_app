
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

  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final signUpTribalNameController = TextEditingController();
  final signUpemailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final signUpPasswordConfirmController = TextEditingController();

  bool validateSigninForm({
    required TextEditingController email,
    required TextEditingController password,
  }) {
    /* isEmail valid */
    if (!GetUtils.isEmail(email.text)) {
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

  bool validateSignupForm(
      {required TextEditingController password,
      required TextEditingController confirmPassword,
      required TextEditingController tribalName,
      required TextEditingController email}) {
    RegExp regExpTribalName = RegExp(
      // A-Za-z0-9_ all letters numbers and _
      r"^[\w]{3,10}$",
      caseSensitive: false,
      multiLine: false,
    );

    if (!validateSigninForm(email: email, password: password)) {
      return false;
    } else if (password != confirmPassword)
      return false;
    else if (!regExpTribalName.hasMatch(tribalName.text)) {
      Get.showSnackbar(customSnackbar(
          'Tribal name should from 3 to 10 letters and can conntain letters, numbers, and underscores'));
      tribalName.clear();
      return false;
    } else if (password != confirmPassword) {
      Get.showSnackbar(customSnackbar('Passwords must be identical'));
      password.clear();
      confirmPassword.clear();
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
        email: emailController, password: passwordController)) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
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

  Future<void> performSignup() async {
    if (validateSigninForm(
          email: signUpemailController,
          password: signUpPasswordController,
        ) &&
        validateSignupForm(
            confirmPassword: signUpPasswordConfirmController,
            email: signUpemailController,
            password: signUpPasswordController,
            tribalName: signUpTribalNameController)) {
      final UserModel user = UserModel.fromJson({
        'email': emailController.text,
        'name': signUpTribalNameController,
        //Todo how to put the id and time stamp
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
