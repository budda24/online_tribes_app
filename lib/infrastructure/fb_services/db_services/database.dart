import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:get/get.dart';

final db = FirebaseFirestore.instance;

class Database {
  Future<void> createUser(UserModel user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('USERS').doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }
}
