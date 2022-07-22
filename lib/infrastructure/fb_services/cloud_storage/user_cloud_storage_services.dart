import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class UserCloudStorageServices {
  UserCloudStorageServices();

  static final storage = FirebaseStorage.instance;

  Future<Reference?> uploadFile({
    required io.File imageToUpload,
    required String fileName,
    required String userId,
    required String path,
  }) async {
    final Reference ref = storage.ref('$userId/$path').child(fileName);

    await ref.putFile(imageToUpload);

    return Future.value(ref);
  }

  static Future<File> downloadFileFromURL(String url) async {
    print(url);
    Reference _ref = storage.refFromURL(url);
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${_ref.name}');
  }
}
