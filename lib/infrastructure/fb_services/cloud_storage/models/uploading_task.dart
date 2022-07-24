import 'package:firebase_storage/firebase_storage.dart';

class UploadedTask {
  UploadedTask({
    required this.refrence,
    required this.task,
  });
  Reference refrence;
  UploadTask task;
}
