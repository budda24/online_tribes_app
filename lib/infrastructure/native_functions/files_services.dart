import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileServices {
  static Future<void> getImageFileFromAssets(String path) async {
/* await Permission.storage.request();
    if(await Permission.storage.status.isGranted){
final byteData =
        await rootBundle.load('lib/assets/tribel_signs/mothering_tribe.png');
    final tmpPath = (await getTemporaryDirectory()).path;

    final file = File('$tmpPath/lib/assets/tribel_signs/mothering_tribe.png');
    file.writeAsString('contents');
    /*  await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)); */
    } */


    /* return file; */
  }
}
