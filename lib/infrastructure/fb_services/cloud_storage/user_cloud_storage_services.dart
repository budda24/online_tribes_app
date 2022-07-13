import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';

class UserCloudStorageServices {

  const UserCloudStorageServices();
  Future<Reference?> uploadFile(
      {required io.File imageToUpload,
      required String fileName,
      required String userId,
      required String path}) async {
    final Reference ref =
        FirebaseStorage.instance.ref('$userId/$path').child(fileName);

    await ref.putFile(imageToUpload);

    return Future.value(ref);
  }
}
