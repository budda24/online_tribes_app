import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';

import 'package:get/get.dart';
import '../models/user_model.dart';

class UserDBServices {
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(UserDB user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await _db.collection('USERS').doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

  Future<UserDB?> feachUser(String userId) async {
    var snapshot = await _db.collection('USERS').doc(userId).get();
    snapshot.reference.printInfo();
    UserDB? user;
    if (snapshot.exists) {
      var userDoc = snapshot.data();

      user = UserDB.fromJson(userDoc!);
    }
    return user;
  }
}
