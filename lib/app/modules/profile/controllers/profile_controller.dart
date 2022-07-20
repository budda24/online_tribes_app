/* import 'package:chewie/chewie.dart'; */

import 'package:flutter_application_1/app/modules/profile/widgets/noticification_tile_accepted.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/noticification_tile_invited.dart';
import 'package:flutter_application_1/app/modules/profile/widgets/noticification_tile_rejected.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import 'package:video_viewer/video_viewer.dart';

import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_info_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_my_tribe_view.dart';
import 'package:flutter_application_1/app/modules/profile/views/profile_notyfications_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/auth/auth_services.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 1.obs;

  bool isShrinkWrap = true;

  List<Type> bottomNavigationBarPages = [
    ProfileInfoView,
    ProfileNotyficationsView,
    ProfileMyTribeView
  ];

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
  String profilePhoto = '';
  void assignProfileInfo() async {
    describtionController.text = userDb?.description ?? '';
    lifeMottoController.text = userDb?.lifeMotto ?? '';
    hobby1Controller.text = userDb?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDb?.hobbies?.hobby1 ?? '';
    timeToInvestController.text = userDb?.timeToInvest.toString() ?? '';
    profileVideo = userDb!.introVideoUrl!;
    profilePhoto = userDb!.profilePhoto!;

    update();
  }

  ProfileNotification get _notification {
    var userNotification = userDb?.profileNotification;
    return ProfileNotification(
      acceptedRequest: userNotification?.acceptedRequest,
      rejectedRequest: userNotification?.rejectedRequest,
      tribalRequest: userNotification?.tribalRequest,
    );
  }

  List<Widget> get notificationWidgets {
    List<Widget> notificationWidgetList = [];

    _notification.acceptedRequest?.forEach((e) {
      notificationWidgetList.add(const NotificationTileAccepted());
    });
    _notification.rejectedRequest?.forEach((e) {
      notificationWidgetList.add(const NotificationTileRejected());
    });
    _notification.tribalRequest?.forEach((e) {
      notificationWidgetList.add(const NotificationTileInvited());
    });

    notificationWidgetList.shuffle();

    return notificationWidgetList;
  }

  @override
  void onInit() async {
    await getUser();

    super.onInit();
  }
}
