// Package imports:

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helpers/theme/alert_styles.dart';

class GlobalController extends GetxController {
  String currentUserRole = '';
  final box = GetStorage();

  RxBool isLoadingVisible = false.obs;

  bool isCurrentUserInDB = false;

  Future<void> saveRegistrationState() async {
    isCurrentUserInDB = true;
    await box.write('isCurrentUserInDB', isCurrentUserInDB);
  }

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  showloading() {
    isLoadingVisible.value = true;
  }

  hideLoading() {
    isLoadingVisible.value = false;
  }

  bool validateInput(
      {required String value, required int lenght, required inputType}) {
    if (value.isEmpty) {
      showErrror('You have to put something in $inputType !!!');
      return false;
    }
    if (value.length > lenght) {
      showErrror(
          'in $inputType Max message lenght = ${lenght.toString()} char');
      return false;
    }
    return true;
  }

  showErrror(String message) {
    if (Get.isOverlaysClosed) {
      Get.showSnackbar(customSnackbar(message));
    }
  }

  @override
  void onInit() {
    isCurrentUserInDB = box.read('isCurrentUserInDB') ?? isCurrentUserInDB;

    super.onInit();
  }
}
