import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/helpers/widgets/online_tribes/form_field.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:get/get.dart';

import '../../authorization/controllers/login_controller.dart';

class RegistrationController extends GetxController {
  final loginController = Get.find<LoginController>();

  /* GlobalKey<FormState> formKey = GlobalKey(); */

  final signUpTribalNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final smsCodeController = TextEditingController();
  final signUpPasswordConfirmController = TextEditingController();


  // bool validateSignupForm({
  //   required TextEditingController password,
  //   required TextEditingController confirmPassword,
  //   required TextEditingController tribalName,
  //   required TextEditingController email,
  // }) {
  //   RegExp regExpTribalName = RegExp(
  //     // A-Za-z0-9_ all letters numbers and _
  //     r"^[\w]{3,10}$",
  //     caseSensitive: false,
  //     multiLine: false,
  //   );

  //   String errorMessage = '';

  //   if (!loginController.validateSigninForm(email: email, password: password)) {
  //     return false;
  //   }

  //   if (password.text != confirmPassword.text) {
  //     errorMessage += "The passwords don't match";
  //     confirmPassword.clear();
  //   }

  //   if (!regExpTribalName.hasMatch(tribalName.text)) {
  //     errorMessage +=
  //         '\n Tribal name should from 3 to 10 letters and can conntain letters, numbers, and underscores';

  //     tribalName.clear();
  //     return false;
  //   }

  //   if (errorMessage.isEmpty &&
  //       loginController.validateSigninForm(email: email, password: password)) {
  //     return true;
  //   } else {
  //     Get.showSnackbar(customSnackbar(errorMessage));

  //     return false;
  //   }
  // }

/*   void displaycontroller() {
    /* formKey.currentState!.save(); */
    print(signUpPasswordController.text);
    print(signUpEmailController.text);
  } */

  // Future<void> performSignup() async {
  //   if (validateSignupForm(
  //       confirmPassword: signUpPasswordConfirmController,
  //       email: signUpPhoneController,
  //       password: signUpPasswordController,
  //       tribalName: signUpTribalNameController)) {
  //     print(signUpPhoneController.text);
  //     final UserModel user = UserModel.fromJson({
  //       'email': signUpPhoneController.text,
  //       'name': signUpTribalNameController.text,
  //       //Todo how to put the id and time stamp
  //     });
  //     await Auth()
  //         .createUserToAuth(user, loginController.passwordController.text)
  //         .catchError((onError) {
  //       Get.showSnackbar(customSnackbar(onError.toString()));
  //     });
  //   }
  // }

  final auth = FirebaseAuth.instance;
  String verificationID = '';
  bool isSMSCodeHere = false;
  bool isLoadingVisible = false;

  showloading() {
    isLoadingVisible = true;
  }

  turnOffLoading() {
    isLoadingVisible = false;
  }

  Future<void> registerUserByPhone({
    required String mobileNumber,
  }) async {
    showloading();

    await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          turnOffLoading();
          await auth
              .signInWithCredential(phoneAuthCredential)
              .then((response) => print(response.user!.uid));
        },
        verificationFailed: (FirebaseAuthException exception) async {
          turnOffLoading();

          Get.defaultDialog(actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            )
          ], title: 'Error', middleText: exception.message.toString());
        },
        codeSent: (String verificationID, int? resendToken) async {
          turnOffLoading();
          this.verificationID = verificationID;
          isSMSCodeHere = true;

/*           print(verificationID); */
          update();
        },
        codeAutoRetrievalTimeout: (cosTam) async {
/*           print(cosTam); */
        });
  }

  Future<void> verifySMSCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: smsCodeController.text);

    showloading();

    try {
      await auth.signInWithCredential(credential).then((response) {
        if (response.user != null) {
          Get.to(() => const RegistrationDescriptionView());
        }
      });

      turnOffLoading();
    } on FirebaseException catch (e) {
      turnOffLoading();

      Get.snackbar('Firebase Error', e.code.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.off(() => LoginView());
    } on FirebaseException catch (e) {
      Get.snackbar('Firebase Error', e.code.toString());
    }
  }
  // Future<void> createUser() async {
  //   if (validateSignupForm(
  //       password: signUpPasswordController,
  //       confirmPassword: signUpPasswordConfirmController,
  //       tribalName: signUpTribalNameController,
  //       email: signUpPhoneController)) {
  //     print('create user validation: ${signUpPhoneController.text}');
  //     Map<String, Object> userModelJson = {
  //       'email': signUpPhoneController.text,
  //       'name': signUpTribalNameController.text,
  //     };
  //     final UserModel user = UserModel.fromJson(userModelJson);
  //     await Auth().createUserToAuth(user, signUpPasswordController.text);
  //   }
  // }

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
