// Package imports:

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  @override
  void onInit() {
    isCurrentUserInDB = box.read('isCurrentUserInDB') ?? isCurrentUserInDB;

    super.onInit();
  }
}
