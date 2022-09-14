// Package imports:

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/infrastructure/fb_services/firebase_extention.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../app/helpers/theme/alert_styles.dart';
import '../models/user_model.dart';

class UserDBServices {
  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserDB user) async {
    try {
      /* user.createdAt = FieldValue.serverTimestamp(); */
      await _db.collection('USERS').doc(user.userId).set(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }

  Future<void> updateUser(UserDB user) async {
    try {
      await _db.collection('USERS').doc(user.userId).update(user.toJson());
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("User can't be updated because $e"));
    }
  }

  //TODO remove + 0 from id - done only for createFewUsers loop purpose
  Future<UserDB?> fetchUser(String userId) async {
    print(userId + 0.toString());
    var snapshot =
        await _db.collection('USERS').doc(userId + 0.toString()).get();
    print(snapshot.exists);
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

  List<UserDB> snapshotToUserList(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return List.from(snapshots.map((e) => UserDB.fromJson(e.data())));
  }

  Future<List<UserDB>> fetchUsersFromDB({required int limit}) async {
    var snapshot = await _db
        .collection('USERS')
        .orderBy('created_at', descending: true)
        .limit(limit)
        .loadCacheOrServer();

    return snapshotToUserList(
        snapshot.docs as List<QueryDocumentSnapshot<Map<String, dynamic>>>);
  }

  Future<List<UserDB>> fetchUserByEmail({required String email}) async {
    var snapshot =
        await _db.collection('USERS').where('email', isEqualTo: email).get();

    var user =
        List<UserDB>.from(snapshot.docs.map((e) => UserDB.fromJson(e.data())))
            .toList();
    return user;
  }

  Future<List<UserDB>> fetchUserByPhoneNumber(
      {required String phoneNumber}) async {
    var snapshot = await _db
        .collection('USERS')
        .where('phone_number', isEqualTo: phoneNumber)
        .get();

    return List<UserDB>.from(
        snapshot.docs.map((e) => UserDB.fromJson(e.data()))).toList();
  }

  Future<bool> sendInvitationToUser({
    required String invitedUserID,
    required String senderTribeId,
  }) async {
    try {
      await _db.runTransaction((transaction) async {
        DocumentReference<Map<String, dynamic>> userDocRef =
            _db.collection('USERS').doc(invitedUserID);

        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await transaction.get(userDocRef);

        if (userSnapshot.exists) {
          var userNotyficationSnapshot =
              await userSnapshot.get("profile_notification");

          List<Notification> userNotyficationList =
              UserDB.notyficationFromJson(userNotyficationSnapshot);

          var notyficationExist = userNotyficationList.firstWhereOrNull(
                  (element) => element.tribeId == senderTribeId) !=
              null;

          userNotyficationList.addIf(
              !notyficationExist,
              Notification(
                  tribeId: senderTribeId, type: NotificationType.invited));

          var updatedNotyficationJson =
              UserDB.notyficationToJson(userNotyficationList);

          transaction.update(userDocRef, updatedNotyficationJson).printInfo();
        }
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteInvitationUser(
      {required String invitedUserID, required String tribeId}) async {
    /* UserDB? invitedUser = await fetchUser(invitedUserID);
    if (invitedUser != null) {
      invitedUser.profileNotification!.removeWhere(
        (element) => element.tribeId == tribeId,
      );

      await updateUser(invitedUser);

      return true;
    } */
    return false;
  }

  Future<void> createManyUsers(UserDB user, int numberOfUsers) async {
    try {
      for (var i = 0; i < numberOfUsers; i++) {
        user.email = (user.email ?? '') + i.toString();

        user.phoneNumber = (user.phoneNumber ?? '') + i.toString();
        user.userId = user.userId + i.toString();
        user.email = user.email! + i.toString();
        await _db.collection('USERS').doc(user.userId).set(user.toJson());
      }

      /*  await _db.collection('USERS').doc(user.userId).set(user.n()); */
    } on FirebaseException catch (e) {
      Get.showSnackbar(customSnackbar("Account can't be created because $e"));
    }
  }
}
