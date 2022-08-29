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

  Future<void> updateUser(UserDB user) async {
    await _db.collection('USERS').doc(user.userId).update(user.toJson());
  }

  //TODO remove + 0 from id - done only for createFewUsers loop purpose
  Future<UserDB?> feachUser(String userId) async {
    var snapshot =
        await _db.collection('USERS').doc(userId + 0.toString()).get();
    UserDB? user;
    if (snapshot.exists) {
      var userDoc = snapshot.data();
      user = UserDB.fromJson(userDoc!);
    }
    return user;
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

      return snapshot;
    } else {
      var snapshot = await _db
          .collection('USERS')
          .orderBy('created_at')
          .limit(limit)
          .startAfterDocument(startAfter)
          .get();

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
        user.userId = user.userId + i.toString();
        print(user.phoneNumber);
        await _db
            .collection('USERS')
            .doc(user.userId /* + i.toString() */)
            .set(user.toJson());
      }
      /*  await _db.collection('USERS').doc(user.userId).set(user.toJson()); */
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

  Future<void> handleUserInvitation(
      {required String invitedUserID, required String senderID}) async {
    UserDB? invitedUser = await feachUser(invitedUserID);

    List<ProfileNotification> userNotyfication =
        invitedUser!.profileNotification!;

    if (userNotyfication.any((element) => element.tribeId == 'TR$senderID')) {
      userNotyfication
          .removeWhere((element) => element.tribeId == 'TR$senderID');
    } else {
      userNotyfication.add(ProfileNotification(
          createdAt: DateTime.now(), tribeId: 'TR$senderID', type: 'invited'));
    }

    invitedUser.profileNotification = userNotyfication;

    await _db
        .collection('USERS')
        .doc(invitedUserID)
        .update(invitedUser.toJson());
  }
}
