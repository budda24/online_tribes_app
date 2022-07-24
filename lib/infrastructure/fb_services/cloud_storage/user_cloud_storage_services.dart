import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class UserCloudStorageServices {
  UserCloudStorageServices();

  static final storage = FirebaseStorage.instance;

  UploadTask uploadFile({
    required io.File imageToUpload,
    required String fileName,
    required String userId,
    required String path,
  }) {
    final Reference ref = storage.ref('$userId/$path').child(fileName);
    
    return ref.putFile(imageToUpload);

    /* var uploadedtask = UploadedTask(refrence: ref, task: task); */
  }

  static Future<File> downloadFileFromURL(String url) async {
    print(url);
    Reference ref = storage.refFromURL(url);
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${ref.name}');
  }
}
