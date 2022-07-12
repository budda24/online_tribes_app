import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';

class UserCloudStorageServices {
 const UserCloudStorageServices();
  Future<UploadTask?> uploadProfileImage({
    required io.File imageToUpload,
    required String fileName,
    required String userId,
  }) async {
    final Reference ref = FirebaseStorage.instance
        .ref('$userId/profile')
        .child(fileName);
    /*    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else { */
    UploadTask uploadTask = ref.putFile(imageToUpload);

    return Future.value(uploadTask);
  }
}
