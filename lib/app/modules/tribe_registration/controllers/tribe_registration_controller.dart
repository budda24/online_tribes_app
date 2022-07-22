import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TribeRegistrationController extends GetxController {
  RxInt? choosenIndex = 9.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descritionController = TextEditingController();
  TextEditingController purpouseController = TextEditingController();
  TextEditingController goalsController = TextEditingController();
  TextEditingController mottoOfTribeController = TextEditingController();
  TextEditingController weeklySuggestedTimeController = TextEditingController();




  String? validateTribe({required String value, required int lenght}) {
    if (value.isEmpty) {
      return 'write some text';
    }
    if (value.length > lenght) {
      return 'Max message lenght = ${lenght.toString()} char';
    }
    return null;
  }
}
