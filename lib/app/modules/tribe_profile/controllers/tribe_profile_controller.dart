import 'package:flutter/material.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/tribe_model.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/tribe_db_services.dart';
import '../../../controllers/global_controler.dart';

class TribeProfileController extends GetxController {
  var globalController = Get.find<GlobalController>();

  final TextEditingController describtionController = TextEditingController();

  final TextEditingController timeToInvestController = TextEditingController();

  VideoViewerController videoController = VideoViewerController();

  final listKey = GlobalKey<AnimatedListState>();

  var userAuthenticationServieces = Auth();
  var tribeDbServieces = TribeDBServices();
  var userStorageServieces = CloudStorageServices();

  RxInt actualIndex = 0.obs;

  TribeDb? tribeDb;
  String profilePhotoUrl = '';
  String profileVideoSrc = '';

  Future<void> getTribe() async {}

  void assignProfileInfo() async {}

  logout() async {}

  @override
  void onClose() {}
}
