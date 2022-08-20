// Package imports:

import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app/controllers/camera_controller.dart';
import 'package:flutter_application_1/app/controllers/global_controler.dart';
import 'package:flutter_application_1/infrastructure/native_functions/time_converting_services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../../../../infrastructure/fb_services/auth/auth_services.dart';
import '../../../../infrastructure/fb_services/cloud_storage/user_cloud_storage_services.dart';
import '../../../../infrastructure/fb_services/models/tribe_model.dart';
import '../../../helpers/widgets/online_tribes/general/main_constants.dart';

class TribeRegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descritionController = TextEditingController();


  var globalController = Get.find<GlobalController>();
  var cameraController = Get.find<CameraController>();

  RxInt? choosenSignIndex = (-1).obs;
  RxBool isSignChosen = false.obs;
  String? chosenTribalSign;
  io.File? uploadedTribalSign;

  List<Map<String, dynamic>> tribesSigns = [
    {'imagePath': cMotheringTribeSign, 'index': 0},
    {'imagePath': cMusicalTribeSign, 'index': 1},
    {'imagePath': cTravellerTribeSign, 'index': 2},
    {'imagePath': cArtistTribeSign, 'index': 3},
    {'imagePath': cBussinessTribeSign, 'index': 4},
    {'imagePath': cWriteringTribeSign, 'index': 5},
    {'imagePath': cIllnessTribeSign, 'index': 6},
    /* {'imagePath': uploadedTribalSign.path, 'index': 7}, */
  ];
/*   Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
 */
  var tribeDB = TribeDb(tribeId: const Uuid().v1());

  Future<UploadTask> uploadFile(
      {required String fileName,
      required String directory,
      required io.File profileFile}) {
    //TODO cloud function to resize photo to secure the end point
    final storage = UserCloudStorageServices();

    String userId = auth.currentUser!.uid;

    return Future.value(
      storage.uploadFile(
          folder: "Tribes",
          path: directory,
          userId: userId,
          imageToUpload: profileFile,
          fileName: '$fileName${extension(profileFile.path)}'),
    );
  }

  var videoUploaded = false.obs;
  double progress = 0.0;

  Future<void> saveNewTribe() async {
    globalController.showloading();
    await uploadFile(
            fileName: 'tribeImage',
            directory: tribeDB.tribeId,
            profileFile: uploadedTribalSign!)
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

              tribeDB.tribalSign =
                  UploadedFile(downloadUrl: url, metaData: metaData);
            }));

    await uploadFile(
            fileName: 'tribalVideo',
            directory: tribeDB.tribeId,
            profileFile: cameraController.pickedVideo!)
        .then((uploadTask) => uploadTask.snapshotEvents.listen((event) async {
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

                tribeDB.tribalIntroVideo =
                    UploadedFile(downloadUrl: url, metaData: metaData);
              }
            }));

    createTribeDb();

    /* await globalController.saveRegistrationState(); */
    //TODO SAVE registration state
    globalController.hideLoading();
  }

  TimeRange? availableTime;

  createTribeDb() {
    tribeDB.description = descritionController.text;
    tribeDB.tribalName = nameController.text;

    var offset = DateTime.now().timeZoneOffset;
    var timeZone = DateTime.now().timeZoneName;
    tribeDB.weeklySuggestedTime = WeeklySuggestedTime(
        startZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.startTime.hour, offset: offset.inHours),
        endZero: TimeCovertingServices.CountOffsetHour(
            hour: availableTime!.endTime.hour, offset: offset.inHours),
        timeZone: timeZone,
        start: availableTime!.startTime.hour,
        end: availableTime!.endTime.hour);
  }
  assignigTriberers(){

  }
  //TODO assign triberers to a tribe
}
