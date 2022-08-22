//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
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
  var globalController = Get.find<GlobalController>();

  final TextEditingController describtionController = TextEditingController();
  final TextEditingController hobby1Controller = TextEditingController();
  final TextEditingController hobby2Controller = TextEditingController();
  final TextEditingController lifeMottoController = TextEditingController();
  final TextEditingController timeToInvestController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  VideoViewerController? videoController = VideoViewerController();

  final listKey = GlobalKey<AnimatedListState>();

  var userAuthenticationServieces = Auth();
  var userDbServieces = UserDBServices();
  var userStorageServieces = UserCloudStorageServices();

  RxInt actualIndex = 0.obs;

  UserDB? userDb;
  String profilePhotoUrl = '';
  String profileVideo = '';
  bool isShrinkWrap = true;

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    userDb = await userDbServieces.feachUser(auth.currentUser!.uid);
    assignProfileInfo();
  }

  void assignProfileInfo() async {
    profileVideo = userDb?.introVideo!.downloadUrl ?? '';
    profilePhotoUrl = userDb!.profilePhoto!.downloadUrl;
    describtionController.text = userDb?.description ?? '';
    lifeMottoController.text = userDb?.lifeMotto ?? '';
    hobby1Controller.text = userDb?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDb?.hobbies?.hobby1 ?? '';
    //TODO DISPLAY THE CONVERTER TIME/* timeToInvestController.text = userDb?.timeToInvest.toString() ?? ''; */

    //TODO download and store the file localy not working with emulators
    /* profileVideo = await UserCloudStorageServices.downloadFileFromURL(
        userDb!.introVideoUrl!); */
    profileVideo = userDb!.introVideo!.downloadUrl;
    profilePhotoUrl = userDb!.profilePhoto!.downloadUrl;

    update();
  }

  List<Widget> get notificationWidgets {
    List<Widget> notificationWidget = [];

    sortProfileNotyficationsByDate();

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

  sortProfileNotyficationsByDate() {
    _profileNotyfication?.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  Future<void> deleteNotification(String tribeId) async {
    List<ProfileNotification> notification = userDb!.profileNotification!;
    int deletedItemIndex =
        notification.indexWhere((element) => element.tribeId == tribeId);

    removeItemAnimation(deletedItemIndex);

    notification.removeAt(deletedItemIndex);

    // await userDbServieces.updateDoc(userDb!);

    update();
  }

  void removeItemAnimation(int index) {
    Widget removedItem = notificationWidgets.elementAt(index);

    listKey.currentState!.removeItem(
      index,
      (_, animation) {
        return buildItem(removedItem, animation, index);
      },
      duration: const Duration(milliseconds: 700),
    );
  }

  buildItem(Widget item, Animation<double> animation, int index) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: item,
    );
  }

  logout() async {
    await Auth().logout();
  }

  Future<void> deleteUser() async {
    globalController.showloading();
    await userDbServieces.deleteUser(userDb!.userId);
    await userAuthenticationServieces.deleteUser();
    globalController.hideLoading();
    Get.offAllNamed(Routes.LOGIN);
  }

  List<ProfileNotification>? get _profileNotyfication {
    return userDb?.profileNotification;
  }
}
