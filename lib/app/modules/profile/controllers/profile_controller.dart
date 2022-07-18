import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 0.obs;

  bool isShrinkWrap = true;
  bool isShrinkArrow = true;

  void updateIsShrinkArrow() {
    isShrinkArrow = !isShrinkArrow;
    update();
  }

  void updateIsShrinkWrap() {
    isShrinkWrap = !isShrinkWrap;
    update();
  }
}
