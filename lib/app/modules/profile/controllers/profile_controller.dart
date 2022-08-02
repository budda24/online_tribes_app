//Package imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_viewer/video_viewer.dart';
// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/user_cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../widgets/noticification_tile_accepted.dart';
import '../widgets/noticification_tile_invited.dart';
import '../widgets/noticification_tile_rejected.dart';

class ProfileController extends GetxController {
  RxInt actualIndex = 0.obs;

  bool isShrinkWrap = true;

  VideoViewerController? videoController = VideoViewerController();

  final TextEditingController describtionController = TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();

  var userDbServieces = UserDBServices();
  var userStorageServieces = UserCloudStorageServices();
  UserDB? userDb;

  Future<void> getUser() async {
    userDb = await userDbServieces.feachUser(auth.currentUser!.uid);
    assignProfileInfo();
  }

  String profileVideo = '';
  String profilePhotoUrl = '';

  void assignProfileInfo() async {
    profileVideo = userDb?.introVideoUrl ?? '';
    profilePhotoUrl = userDb!.profilePhoto!;
    describtionController.text = userDb?.description ?? '';
    lifeMottoController.text = userDb?.lifeMotto ?? '';
    hobby1Controller.text = userDb?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDb?.hobbies?.hobby1 ?? '';
    timeToInvestController.text = userDb?.timeToInvest.toString() ?? '';

    //TODO download and store the file localy not working with emulators
    /* profileVideo = await UserCloudStorageServices.downloadFileFromURL(
        userDb!.introVideoUrl!); */
    profileVideo = userDb!.introVideoUrl ?? '';
    profilePhotoUrl = userDb!.profilePhoto ?? '';

    update();
  }

  List<ProfileNotification>? get _profileNotyfication {
    return userDb?.profileNotification;
  }

  List<Widget> get notificationWidgets {
    List<Widget> notificationWidget = [];

    _profileNotyfication?.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    _profileNotyfication?.forEach((element) {
      switch (element.type) {
        case 'invited':
          notificationWidget.add(NotificationTileInvited(
            tribeId: element.tribeId,
          ));
          break;
        case 'accepted':
          notificationWidget.add(const NotificationTileAccepted());
          break;
        case 'rejected':
          notificationWidget.add(NotificationTileRejected(
            tribeId: element.tribeId,
          ));
          break;
      }
    });
    return notificationWidget;
  }

  Future<void> deleteNotification(String tribeId) async {
    userDb?.profileNotification
        ?.removeWhere((element) => element.tribeId == tribeId);

    await userDbServieces.updateDoc(userDb!);
    update();
  }

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }
}
