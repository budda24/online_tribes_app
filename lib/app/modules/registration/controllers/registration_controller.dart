import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:get/get.dart';
import '../../authorization/controllers/login_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();

  /* GlobalKey<FormState> formKey = GlobalKey(); */

  final signUpTribalNameController = TextEditingController();
  late final signUpPhoneController = TextEditingController();
  late final signUpPasswordController = TextEditingController();
  final signUpPasswordConfirmController = TextEditingController();

  bool validateSignupForm({
    required TextEditingController password,
    required TextEditingController confirmPassword,
    required TextEditingController tribalName,
    required TextEditingController email,
  }) {
    RegExp regExpTribalName = RegExp(
      // A-Za-z0-9_ all letters numbers and _
      r"^[\w]{3,10}$",
      caseSensitive: false,
      multiLine: false,
    );

    String errorMessage = '';

    if (!loginController.validateSigninForm(email: email, password: password)) {
      return false;
    }

    if (password.text != confirmPassword.text) {
      errorMessage += "The passwords don't match";
      confirmPassword.clear();
    }

    if (!regExpTribalName.hasMatch(tribalName.text)) {
      errorMessage +=
          '\n Tribal name should from 3 to 10 letters and can conntain letters, numbers, and underscores';

      tribalName.clear();
      return false;
    }

    if (errorMessage.isEmpty &&
        loginController.validateSigninForm(email: email, password: password)) {
      return true;
    } else {
      Get.showSnackbar(customSnackbar(errorMessage));

      return false;
    }
  }

/*   void displaycontroller() {
    /* formKey.currentState!.save(); */
    print(signUpPasswordController.text);
    print(signUpEmailController.text);
  } */

  Future<void> performSignup() async {
    if (validateSignupForm(
        confirmPassword: signUpPasswordConfirmController,
        email: signUpPhoneController,
        password: signUpPasswordController,
        tribalName: signUpTribalNameController)) {
      print(signUpPhoneController.text);
      final UserModel user = UserModel.fromJson({
        'email': signUpPhoneController.text,
        'name': signUpTribalNameController.text,
        //Todo how to put the id and time stamp
      });
      await Auth()
          .createUserToAuth(user, loginController.passwordController.text)
          .catchError((onError) {
        Get.showSnackbar(customSnackbar(onError.toString()));
      });
    }
  }

  Future<void> createUser() async {
    if (validateSignupForm(
        password: signUpPasswordController,
        confirmPassword: signUpPasswordConfirmController,
        tribalName: signUpTribalNameController,
        email: signUpPhoneController)) {
      print('create user validation: ${signUpPhoneController.text}');
      Map<String, Object> userModelJson = {
        'email': signUpPhoneController.text,
        'name': signUpTribalNameController.text,
      };
      final UserModel user = UserModel.fromJson(userModelJson);
      await Auth().createUserToAuth(user, signUpPasswordController.text);
    }
  }

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
    CustomTextField(
      controller: RegistrationController._hobbyController1,
      height: 55,
      width: 500,
      hintText: 'Hobbies',
      maxline: 1,
      minLine: 1,
      onSave: (value) {
        addHobby(value);
      },
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
    hobbiesFields.add(
      CustomTextField(
        controller: hobbyControllers[_index],
        height: 60,
        width: 500,
        hintText: 'Hobbies $_index',
        maxline: 1,
        minLine: 1,
        onSave: (value) {
          addHobby(value);
        },
      ),
    );
    _index++;
  }

  @override
  void onClose() {}
}
