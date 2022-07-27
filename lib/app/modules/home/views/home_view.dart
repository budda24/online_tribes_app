
//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Project imports:
import '../../../controllers/global_controler.dart';

import '../../../helpers/widgets/online_tribes/general/main_constants.dart';
import '../../../routes/app_pages.dart';
import '../../authorization/controllers/login_controller.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  var loginController = Get.put(LoginController());
  var globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    globalController.hideLoading();


    return Obx(
      () => globalController.isLoadingVisible.value
          ? spinkit
          : Scaffold(
              appBar: AppBar(
                title: const Text('HomeView'),
                centerTitle: true,
              ),
              body: Center(
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    /* await auth.signOut(); */
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  splashColor: Colors.blueGrey,
                  child: GestureDetector(
                    onTap: () async => await loginController.logout(),
                    child: const Text(
                      'logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
