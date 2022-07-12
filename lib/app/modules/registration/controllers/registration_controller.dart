import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/user_model.dart';
import 'package:get/get.dart';

import '../../authorization/controllers/login_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();

  RxDouble sliderValue = 1.0.obs;

  final TextEditingController describeYourselfController =
      TextEditingController();

  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  UserDB userDB = UserDB(
    userId: currentUser.uid,
  );

  Future<void> saveNewUser() async {
    userDB.description = describeYourselfController.text;
    userDB.lifeMotto = lifeMottoController.text;
    userDB.hobby = hobbyController.text;
    userDB.timeToInvest = sliderValue.value.toInt();
    userDB.email = currentUser.email;
    userDB.phoneNumber = currentUser.phoneNumber;
    userDB.introVideoUrl = 'Test test http';

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
}
