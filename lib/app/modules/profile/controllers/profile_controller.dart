/* import 'package:chewie/chewie.dart'; */

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:video_viewer/domain/bloc/controller.dart';

import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';

import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 0.obs;

  bool isShrinkWrap = true;

  final VideoViewerController videoController = VideoViewerController();

  final TextEditingController describtionController = TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  var userDbServieces = UserDBServices();
  UserDB? userDb;

  Future<void> getUser() async {
    userDb = await userDbServieces.feachUser(auth.currentUser!.uid);
    assignProfileInfo();
  }

  late String profileVideo;
  late String profilePhoto;

  void assignProfileInfo() async {
    describtionController.text = userDb?.description ?? '';
    lifeMottoController.text = userDb?.lifeMotto ?? '';
    hobby1Controller.text = userDb?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDb?.hobbies?.hobby1 ?? '';
    timeToInvestController.text = userDb?.timeToInvest.toString() ?? '';
    profileVideo = userDb?.introVideoUrl ??
        'https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4';
    profilePhoto = userDb!.profilePhoto!;

    update();

    /* await initializePlayer(); */
  }

  @override
  void onInit() async {
    await getUser();

    super.onInit();
  }
}
