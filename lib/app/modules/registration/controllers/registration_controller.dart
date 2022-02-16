import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  Rx<double> range = 5.0.obs; //again initialized it to a Rx<double>

  void setRange(double range) {
    this.range.value = range; //updating the value of Rx Variable.
  }

  final count = 0.obs;

  final tribalNameController = TextEditingController();
  static List<String> hobbies = [];
  static void addHobby(String value) {
    hobbies.add(value);
  }

  static var hobbiesFieldsController = ScrollController();

  RxList<Widget> hobbiesFields = [
    CustomTextField(
      
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
   int index = 1;
  void addHobbyField() {

    hobbiesFields.add(
      CustomTextField(
        height: 60,
        width: 500,
        hintText: 'Hobbies $index',
        maxline: 1,
        minLine: 1,
        onSave: (value) {
          addHobby(value);
        },
      ),
    );
    index++;
  }

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
  void increment() => count.value++;
}
