// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/tribal_type.dart';
import 'package:flutter_application_1/infrastructure/fb_services/models/tribe_model.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../app/helpers/theme/alert_styles.dart';

class TribeDBServices {
  final _db = FirebaseFirestore.instance;
  Future<void> createTribe(TribeDb tribe) async {
    print('create a tribe');
    try {
      tribe.createdAt = FieldValue.serverTimestamp();
      await _db.collection('TRIBES').doc(tribe.tribeId).set(tribe.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

  Future<TribeDb?> feachTribe(String tribeId) async {
    var snapshot = await _db.collection('TRIBES').doc(tribeId).get();
    TribeDb? tribe;
    if (snapshot.exists) {
      var tribeDoc = snapshot.data();
      print(tribeDoc);
      tribe = TribeDb.fromJson(tribeDoc!);
    }
    return tribe;
  }

  Future<void> updateTribe(TribeDb tribe) async {
    await _db.collection('TRIBES').doc(tribe.tribeId).update(tribe.toJson());
  }

  Future<void> deleteTribe(String tribeId) async {
    await _db.collection('TRIBES').doc(tribeId).delete();
  }

  Future<TribalType?> fechListTribalTypes() async {
    var docSnapshot = await _db.collection('TRIBES').doc('tribalTypes').get();
    if (docSnapshot.exists) {
      return TribalType.fromJson(docSnapshot.data()!);
    }
    return null;
  }

  Future<void> updateListTribalTypes(TribalType type) async {
    await _db.collection('TRIBES').doc('tribalTypes').set(type.toJson());
  }
}
