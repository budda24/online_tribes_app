//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/controllers/registration_controller.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:video_viewer/video_viewer.dart';
// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/db_services/user_db_services.dart';
import '../../../../infrastructure/fb_services/models/user_model.dart';
import '../../../../infrastructure/native_functions/time_converting_services.dart';
import '../../../controllers/camera_controller.dart';
import '../widgets/noticification_tile_accepted.dart';
import '../widgets/noticification_tile_invited.dart';
import '../widgets/noticification_tile_rejected.dart';

class ProfileController extends GetxController {
  var globalController = Get.find<GlobalController>();
  final cameraController = Get.put(CameraController());
  final registrationController = Get.put(RegistrationController());

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
  var userStorageServieces = CloudStorageServices();

  RxInt actualIndex = 0.obs;

  UserDB? userDB;
  UserDB? previousUserDB;

  bool isShrinkWrap = true;
  bool isEditingMode = false;
  TimeRange? availableTime;
  bool isPhotoAndVideoBoutchUpdated = false;

  double progress = 0.0;

  Future<void> getUser() async {
    print('featch user');
    userDB = await userDbServieces.fetchUser(auth.currentUser!.uid);
    assignProfileInfo();
  }

  void assignProfileInfo() async {
    describtionController.text = userDB?.description ?? '';
    lifeMottoController.text = userDB?.lifeMotto ?? '';
    hobby1Controller.text = userDB?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDB?.hobbies?.hobby1 ?? '';
    videoController = VideoViewerController();
    //TODO DISPLAY THE CONVERTER TIME/* timeToInvestController.text = userDb?.timeToInvest.toString() ?? ''; */

    //TODO download and store the file localy not working with emulators
    /* profileVideo = await UserCloudStorageServices.downloadFileFromURL(
        userDb!.introVideoUrl!); */

    update();
  }

  void assignUpdatedUserInfo() async {
    userDB?.description = describtionController.text;
    userDB?.lifeMotto = lifeMottoController.text;
    userDB?.hobbies?.hobby = hobby1Controller.text;
    userDB?.hobbies?.hobby1 = hobby2Controller.text;
  }

  prepareEditingMode() {
    saveUserLocally();

    isEditingMode = true;
    availableTime = null;
    update();
  }

  saveUserLocally() {
    previousUserDB = userDB;
  }

  cancelUserChanges() {
    userDB = previousUserDB;
    assignProfileInfo();

    update();
  }

  AvailableTime createAvailableTime() {
    var timeZone = DateTime.now().timeZoneName;
    var timeZoneOffset = DateTime.now().timeZoneOffset.inHours;
    return AvailableTime(
        endZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.endTime.hour, offset: timeZoneOffset),
        startZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.startTime.hour, offset: timeZoneOffset),
        timeZone: timeZone,
        start: availableTime!.startTime.hour,
        end: availableTime!.endTime.hour);
  }

  Future<void> updateUser() async {
    assignUpdatedUserInfo();
    /*   print('before:${userDB!.profilePhotoRef!.downloadUrl}'); */

    if (availableTime != null) {
      userDB!.availableTime = createAvailableTime();
    }

    if (cameraController.pickedPhoto != null) {
      await registrationController.uploadFile(
        getRefrence: (ref) async {
          userDB!.profilePhotoRef = await registrationController.getRef(ref);
          /*   print('after:${userDB!.profilePhotoRef!.downloadUrl}'); */
        },
        fileName: 'profileImage',
        directory: 'profile',
        profileFile: cameraController.pickedPhoto!,
        functionAfterUploaded: () async {
          if (!isVideoAndPhotoChosen()) {
            await userDbServieces.updateUser(userDB!);
            update();
          }
        },
      );
    }

    if (cameraController.pickedVideo != null) {
      await registrationController.uploadFile(
        getRefrence: (ref) async {
          userDB!.introVideoRef = await registrationController.getRef(ref);
        },
        fileName: 'profileVideo',
        directory: 'profile',
        profileFile: cameraController.pickedVideo!,
        functionAfterUploaded: () async {
          await userDbServieces.updateUser(userDB!);
          registrationController.update();
        },
      );
    }

    isEditingMode = false;

    assignProfileInfo();
  }

  bool isVideoAndPhotoChosen() {
    if (cameraController.pickedPhoto != null &&
        cameraController.pickedVideo != null) {
      return true;
    }
    return false;
  }

  List<Widget> get notificationWidgets {
    List<Widget> notificationWidget = [];

    /* sortProfileNotyficationsByDate();

    _profileNotyfication?.forEach((element) {
      switch (element.type) {
        case NotificationType.invited:
          notificationWidget.add(NotificationTileInvited(
            tribeId: element.tribeId,
          ));
          break;
        case NotificationType.accepted:
          notificationWidget.add(const NotificationTileAccepted());
          break;
        case NotificationType.rejected:
          notificationWidget.add(NotificationTileRejected(
            tribeId: element.tribeId,
          ));
          break;
      }
    }); */
    return notificationWidget;
  }

  /* sortProfileNotyficationsByDate() {
    _profileNotyfication?.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  } */

  Future<void> deleteNotification(String tribeId) async {
    /* List<Notification> notification = userDB!.profileNotification!;
    int deletedItemIndex =
        notification.indexWhere((element) => element.tribeId == tribeId);

    removeItemAnimation(deletedItemIndex);

    notification.removeAt(deletedItemIndex);

    // await userDbServieces.updateDoc(userDb!);

    update(); */
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
    await userDbServieces.deleteUser(userDB!.userId);
    await userAuthenticationServieces.deleteUser();
    globalController.hideLoading();
    Get.offAllNamed(Routes.LOGIN);
  }

  /* List<Notification>? get _profileNotyfication {
    return userDB?.profileNotification;
  } */

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }
}
