import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  Rx<double> range = 5.0.obs; //again initialized it to a Rx<double>

  void setRange(double range) {
    this.range.value = range; //updating the value of Rx Variable.
  }

  final tribalNameController = TextEditingController();
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
