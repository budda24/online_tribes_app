import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';

import 'package:get/get.dart';
import '../models/user_model.dart';

class UserDBServices {
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(UserDB user) async {
    try {
      print('try to create user db');
      user.createdAt = FieldValue.serverTimestamp();
      await _db.collection('USERS').doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

/*   Future<bool> userExist({String phoneNumber = '', String email = ''}) async {
    final userRef = _db.collection('USERS');
    if (phoneNumber.isEmpty) {
      await userRef.where('email' == email).get().then((docSnapshot) {
        if (docSnapshot.docs.isNotEmpty) {
          return true;
        }
      });
    } else {
      await userRef
          .where('phone_number' == phoneNumber)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.docs.isNotEmpty) {
          return true;
        }
      });
    }

    return false;
  } */
}
