//Package imports:
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
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
  String profilePhotoUrl = '';
  String profileVideo = '';
  bool isShrinkWrap = true;
  bool isEditingMode = false;
  TimeRange? availableTime;

  double progress = 0.0;

  @override
  void onInit() async {
    await getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    userDB = await userDbServieces.feachUser(auth.currentUser!.uid);
    assignProfileInfo();
  }

  void assignProfileInfo() async {
    profileVideo = userDB?.introVideo!.downloadUrl ?? '';
    profilePhotoUrl = userDB!.profilePhoto!.downloadUrl;
    describtionController.text = userDB?.description ?? '';
    lifeMottoController.text = userDB?.lifeMotto ?? '';
    hobby1Controller.text = userDB?.hobbies?.hobby ?? '';
    hobby2Controller.text = userDB?.hobbies?.hobby1 ?? '';
    //TODO DISPLAY THE CONVERTER TIME/* timeToInvestController.text = userDb?.timeToInvest.toString() ?? ''; */

    //TODO download and store the file localy not working with emulators
    /* profileVideo = await UserCloudStorageServices.downloadFileFromURL(
        userDb!.introVideoUrl!); */

    update();
  }

  Future<UploadedFile> getRef(Reference ref) async {
    var url = await ref.getDownloadURL();
    var metaDataRef = await ref.getMetadata();

    var metaData = Metadata(
        bucket: metaDataRef.bucket,
        name: metaDataRef.name,
        size: metaDataRef.size!,
        fullPath: metaDataRef.fullPath,
        contentType: metaDataRef.contentType!,
        timeCreated: metaDataRef.timeCreated,
        contentEncoding: metaDataRef.contentEncoding);

    return UploadedFile(downloadUrl: url, metaData: metaData);
  }

  listenToProgress(TaskSnapshot event) {
    if (event.state == TaskState.running) {
      progress =
          ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();
      update();
    }
  }

  Future uploadFile({
    required String fileName,
    required String directory,
    required io.File profileFile,
    required Future Function(Reference ref) getRefrence,
    bool recordingTheProgress = false,
  }) async {
    //TODO cloud function to resize photo to secure the end point
    final storage = CloudStorageServices();
    String userId = auth.currentUser!.uid;
    storage
        .uploadFile(
            folder: "Users",
            path: directory,
            userId: userId,
            imageToUpload: profileFile,
            fileName: '$fileName${extension(profileFile.path)}')
        .snapshotEvents
        .listen((event) async {
      if (recordingTheProgress) {
        listenToProgress(event);
      }
      if (event.state == TaskState.success) {
        await getRef(event.ref);
      }
    });
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

    await uploadFile(
        getRefrence: (ref) async {
          if (userDB!.introVideo != await getRef(ref)) {
            userDB!.introVideo = await getRef(ref);
          } else {
            return;
          }
        },
        recordingTheProgress: true,
        fileName: 'profileVideo',
        directory: 'profile',
        profileFile: cameraController.pickedVideo!);


  }

  /*  Future<UploadTask> uploadFile(
      {required String fileName,
      required String directory,
      required io.File profileFile}) {
    //TODO cloud function to resize photo to secure the end point
    final storage = UserCloudStorageServices();

    String userId = auth.currentUser!.uid;

    return Future.value(
      storage.uploadFile(
          folder: "Users",
          path: directory,
          userId: userId,
          imageToUpload: profileFile,
          fileName: '$fileName${extension(profileFile.path)}'),
    );
  } */

  /*  Future<void> updateUser() async {
    await uploadFile(
            fileName: 'profileImage',
            directory: 'profile',
            profileFile: cameraController.pickedPhoto!)
        .then((taskSnapshot) => taskSnapshot.then((upladTask) async {
              var url = await upladTask.ref.getDownloadURL();
              var metaDataRef = await upladTask.ref.getMetadata();
              var metaData = Metadata(
                  bucket: metaDataRef.bucket,
                  name: metaDataRef.name,
                  size: metaDataRef.size!,
                  fullPath: metaDataRef.fullPath,
                  contentType: metaDataRef.contentType!,
                  timeCreated: metaDataRef.timeCreated,
                  contentEncoding: metaDataRef.contentEncoding);

              userDB!.profilePhoto =
                  UploadedFile(downloadUrl: url, metaData: metaData);
            }));

    await uploadFile(
            fileName: 'profileVideo',
            directory: 'profile',
            profileFile: cameraController.pickedVideo!)
        .then(
      (uploadTask) => uploadTask.snapshotEvents.listen(
        (event) async {
          if (event.state == TaskState.running) {
            progress = ((event.bytesTransferred.toDouble() /
                        event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();

            update();
          }
          if (event.state == TaskState.success) {
            var url = await event.ref.getDownloadURL();
            var metaDataRef = await event.ref.getMetadata();
            var metaData = Metadata(
                bucket: metaDataRef.bucket,
                name: metaDataRef.name,
                size: metaDataRef.size!,
                fullPath: metaDataRef.fullPath,
                contentType: metaDataRef.contentType!,
                timeCreated: metaDataRef.timeCreated,
                contentEncoding: metaDataRef.contentEncoding);

            userDB!.introVideo =
                UploadedFile(downloadUrl: url, metaData: metaData);
          }
        },
      ),
    );
  } */

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
    List<ProfileNotification> notification = userDB!.profileNotification!;
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
    await userDbServieces.deleteUser(userDB!.userId);
    await userAuthenticationServieces.deleteUser();
    globalController.hideLoading();
    Get.offAllNamed(Routes.LOGIN);
  }

  List<ProfileNotification>? get _profileNotyfication {
    return userDB?.profileNotification;
  }

  rebuild() {
    update();
  }
}
