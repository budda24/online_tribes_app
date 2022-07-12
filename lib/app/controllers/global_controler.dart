// Package imports:

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController {
  String currentUserRole = '';
  final box = GetStorage();

  RxBool isLoadingVisible = false.obs;
  /* List<CameraDescription>? camera; */

  // User? user;
  // void isUserLogged() {
  //   if (auth.currentUser != null) {
  //     user = auth.currentUser;
  //     Get.offAllNamed(Routes.HOME);
  //   } else {
  //     user = null;
  //     Get.offAll(LoginView());
  //   }
  // }

  void unFocuseNode() {
    Get.focusScope!.unfocus();
  }

  showloading() {
    isLoadingVisible.value = true;
  }

  hideLoading() {
    isLoadingVisible.value = false;
  }
}
