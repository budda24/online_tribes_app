// Package imports:
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class GlobalController extends GetxController {
  String currentUserRole = '';
  final box = GetStorage();


  @override
  void onInit() async {
    /* if (box.read('isWalkthroughDone') == null ||
        !box.read('isWalkthroughDone')) {
    } else {
      print('Already Visited');
    } */
    super.onInit();
  }
}
