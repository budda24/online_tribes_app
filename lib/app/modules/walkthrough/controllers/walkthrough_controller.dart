import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../helpers/controllers/global_controller.dart';
/* import '../../../modules/authorization/views/login_view.dart'; */
import '../../../modules/walkthrough/models/walkthrough_model.dart';
import '../../../routes/app_pages.dart';

class WalkthroughController extends GetxController {
  PageController? pageController;
  RxDouble currentPage = 0.0.obs;
  RxList<WalkThroughModel> onBoardingList =
      <WalkThroughModel>[].obs; //why need to observe that

  //onNotification: controller.onScroll, used in the view
  bool onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics) {
      //why we need to check that ?
      currentPage.value = metrics.page ?? 0.0;
    }
    return false;
  }

  void continuButton() {
    //! how to add to the value of obs
    pageController!.animateTo(currentPage.value.toInt() + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  void onTap() {
    //check if the last walk true step
    if (currentPage.value >= 1.5) {
      //set the mobile cookie to true for not displaying to user who have seen
      _saveBoxWalktrough();
      Get.toNamed(Routes.LOGIN);
    }
    //caling animation on the page contrler
    pageController!.animateToPage(currentPage.value.toInt() + 1,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  void onSkipPressed() {
    _saveBoxWalktrough();
    Get.toNamed(Routes.LOGIN);
    // Get.to(LoginView()); // When you follow direct routing, the routing classes will not make any sense. Routing files are not going to be used.
  }

  void _saveBoxWalktrough() {
    Get.find<GlobalController>().box.write('isWalkthroughDone', true);
  }

  @override
  //!why we need to resign the list on ini ?
  void onInit() {
    super.onInit();
    pageController = PageController();
    /* Get.find<GlobalController>().box.remove('isWalkthroughDone'); */

    onBoardingList.value = [
      WalkThroughModel(
        imageName: 'assets/images/welcome_screans/screen_1.png',
        title: 'Create or Join \n your tribe',
        /* description:
            'Handpick your Fruits & Vegetables from the Vishals Cart. Touch & Feel - Pick & Choose.', */
      ),
      WalkThroughModel(
        imageName: 'assets/images/welcome_screans/screen_2.png',
        title: 'Built \n Relationship',
        /* description:
            'Get your groceries delivered from the comfort of your couch.', */
      ),
      WalkThroughModel(
        imageName: 'assets/images/welcome_screans/screen_3.png',
        title: 'Be a Family',
        /* description:
            'We ensure contactless delivery since Your safety is our priority.', */
      ),
    ];
  }

  @override
  void dispose() {
    pageController!.dispose();
    super.dispose();
  }
}
