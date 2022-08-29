// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../app/helpers/theme/alert_styles.dart';
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
    UserDB? user;
    if (snapshot.exists) {
      var userDoc = snapshot.data();
      user = UserDB.fromJson(userDoc!);
    }
    return user;
  }

  Future<void> updateUser(UserDB user) async {
    await _db.collection('USERS').doc(user.userId).update(user.toJson());
  }

  Future<void> deleteUser(String userId) async {
    await _db.collection('USERS').doc(userId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchLimitedUsers(
      {required int limit, DocumentSnapshot? startAfter}) async {
    if (startAfter == null) {
      var snapshot = await _db
          .collection('USERS')
          .orderBy('created_at')
          .limit(limit)
          .get();
      // var userList = List<UserDB>.from(
      //     snapshot.docs.map((e) => UserDB.fromJson(e.data())).toList());

      return snapshot;
    } else {
      var snapshot = await _db
          .collection('USERS')
          .orderBy('created_at')
          .limit(limit)
          .startAfterDocument(startAfter)
          .get();

      // var userList = List<UserDB>.from(
      //     snapshot.docs.map((e) => UserDB.fromJson(e.data())).toList());
      return snapshot;
    }
  }

  Future<List<UserDB>> feachUserByEmail({required String email}) async {
    var snapshot =
        await _db.collection('USERS').where('email', isEqualTo: email).get();

    var user =
        List<UserDB>.from(snapshot.docs.map((e) => UserDB.fromJson(e.data())))
            .toList();
    return user;
  }

  Future<List<UserDB>> feachUserByPhoneNumber(
      {required String phoneNumber}) async {
    var snapshot = await _db
        .collection('USERS')
        .where('phone_number', isEqualTo: phoneNumber)
        .get();

    var user =
        List<UserDB>.from(snapshot.docs.map((e) => UserDB.fromJson(e.data())))
            .toList();
    return user;
  }

  Future<void> createFewUser(UserDB user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      for (var i = 0; i < 20; i++) {
        user.email = (user.email ?? '') + i.toString();
        print(user.email);
        user.phoneNumber = (user.phoneNumber ?? '') + i.toString();
        print(user.phoneNumber);
        await _db
            .collection('USERS')
            .doc(user.userId + i.toString())
            .set(user.toJson());
      }
      await _db.collection('USERS').doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }
}
