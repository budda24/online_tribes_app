import 'package:chewie/chewie.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_info_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_my_tribe_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_notyfications_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 1.obs;

  bool isShrinkWrap = true;

  List<Widget> bottomNavigationBarPages = [
    ProfileView(),
    ProfileNotyficationsView(),
    ProfileMyTribeView()
  ];

  /* TargetPlatform? _platform; */
  late VideoPlayerController _videoPlayerController1;
  ChewieController? chewieController;

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(profileVideo);
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    update();
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: true,
      hideControlsTimer: const Duration(seconds: 1),
      showOptions: false,
    );
  }

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
    print(profilePhoto);
    print(profileVideo);
    update();

    await initializePlayer();
  }

  @override
  void onInit() async {
    /* await getUser(); */

    super.onInit();
  }

  @override
  void onClose() {
    _videoPlayerController1.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
