import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../infrastructure/fb_services/auth/auth_services.dart';
import '../../infrastructure/fb_services/cloud_storage/cloud_storage_services.dart';
import 'global_controler.dart';

class RegistrationController extends GetxController {
  var globalController = Get.find<GlobalController>();

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

  Future uploadFile({
    required String fileName,
    required String directory,
    required io.File profileFile,
    required Future Function(Reference) getRefrence,
    Future Function()? functionAfterUploaded,
    Function(TaskSnapshot)? listenToProgress,
  }) async {
    //TODO cloud function to resize photo to secure the end point
    final storage = CloudStorageServices();
    String userId = auth.currentUser!.uid;
    return storage
        .uploadFile(
            folder: "Tribes",
            path: directory,
            userId: userId,
            imageToUpload: profileFile,
            fileName: '$fileName${extension(profileFile.path)}')
        .snapshotEvents
        .listen((event) async {
      if (listenToProgress != null) {
        listenToProgress(event);
      }
      if (event.state == TaskState.success) {
        var ref = event.ref;
        await getRefrence(ref);
        if (functionAfterUploaded != null) {
          await functionAfterUploaded();
        }
      }
    });
  }

  bool isTimeChosen(TimeRange? availableTime) {
    if (availableTime != null) {
      return true;
    } else {
      globalController.showErrror('Available time not chosen');
      return false;
    }
  }
}
