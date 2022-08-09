// Package imports:
import 'dart:io' as io;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_model.dart';

class UserCloudStorageServices {
  UserCloudStorageServices();

  static final storage = FirebaseStorage.instance;

  UploadTask uploadFile({
    required io.File imageToUpload,
    required String fileName,
    required String userId,
    required String path,
  }) {
    final Reference ref = storage.ref('USERS/$userId/$path').child(fileName);

    return ref.putFile(imageToUpload);

    /* var uploadedtask = UploadedTask(refrence: ref, task: task); */
  }

  static Future<File> downloadFileFromURL(String url) async {
    print(url);
    Reference ref = storage.refFromURL(url);
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${ref.name}');
  }

   Future<void> deleteAssetsUser(UserDB user) async {

  }

  //TODO write function to delete here || deleting doc with tribe_id
}
