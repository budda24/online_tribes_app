import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/tribe_model.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/tribe_db_services.dart';
import '../../../controllers/global_controler.dart';

class TribeProfileController extends GetxController with StateMixin<TribeDb> {
  var globalController = Get.find<GlobalController>();

  final TextEditingController describtionController = TextEditingController();

  final TextEditingController timeToInvestController = TextEditingController();

  final listKey = GlobalKey<AnimatedListState>();

  var userAuthenticationServieces = Auth();
  var tribeDbServieces = TribeDBServices();
  var userStorageServieces = CloudStorageServices();

  RxInt actualIndex = 0.obs;

  TribeDb? tribeDb;

  Future<void> getTribe() async {
    tribeDb = await tribeDbServieces
        .feachTribe('65e7bcc0-2864-11ed-84d0-5df98aa18c71');
    update();
  }

  VideoViewerController videoController = VideoViewerController();
  ifPlayFullScren() {


  }

  logout() async {}

  @override
  void onInit() async {
    await getTribe();
    super.onInit();
  }

  @override
  void onClose() {}
}
