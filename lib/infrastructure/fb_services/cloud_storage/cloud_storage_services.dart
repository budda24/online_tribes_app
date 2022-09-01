// Package imports:
import 'dart:io' as io;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class CloudStorageServices {
  CloudStorageServices();

  static final storage = FirebaseStorage.instance;

  UploadTask uploadFile({
    required io.File imageToUpload,
    required String fileName,
    required String userId,
    required String path,
    required String folder,
  }) {
    final Reference ref = storage.ref('$folder/$userId/$path').child(fileName);

    return ref.putFile(imageToUpload);

    /* var uploadedtask = UploadedTask(refrence: ref, task: task); */
  }

  static Future<File> downloadFileFromURL(String url) async {
    print(url);
    Reference ref = storage.refFromURL(url);
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/${ref.name}');
  }

  //TODO write function to delete here || deleting doc with tribe_id
}

class UploadedFile {
  UploadedFile({
    required this.downloadUrl,
    required this.metaData,
  });

  String downloadUrl;
  Metadata metaData;

  factory UploadedFile.fromJson(Map<String, dynamic> json) => UploadedFile(
        downloadUrl: json["downloadUrl"],
        metaData: Metadata.fromJson(json["metaData"]),
      );

  Map<String, dynamic> toJson() => {
        "downloadUrl": downloadUrl,
        "metaData": metaData.toJson(),
      };
}

class Metadata {
  Metadata({
    required this.bucket,
    required this.name,
    required this.size,
    required this.fullPath,
    required this.contentType,
    required this.timeCreated,
    required this.contentEncoding,
  });

  final String? bucket;
  final String fullPath;
  final int size;
  final DateTime? timeCreated;
  final String contentType;
  final String? contentEncoding;
  final String name;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        bucket: json["bucket"],
        fullPath: json["fullPath"],
        size: json["size"],
        timeCreated: ((json["timeCreated"]) as Timestamp).toDate(),
        contentType: json["contentType"],
        contentEncoding: json["contentEncoding"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "bucket": bucket,
        "fullPath": fullPath,
        "size": size,
        "timeCreated": timeCreated,
        "contentType": contentType,
        "contentEncoding": contentEncoding,
        "name": name,
      };
}