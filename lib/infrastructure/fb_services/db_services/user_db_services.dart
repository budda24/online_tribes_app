// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../app/helpers/theme/alert_styles.dart';
import '../models/user_model.dart';

class UserDBServices {
  final _db = FirebaseFirestore.instance;
  Future<void> createUser(UserDB user) async {
    print('creating user');
    try {
      // user.createdAt = FieldValue.serverTimestamp();
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

      /* var jsonEnc = json.encode(snapshot.data());
      print('json: $jsonEnc'); */

      user = UserDB.fromJson(userDoc!);
      print(
          '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      print('user ProfileN: ${user.description}');
      // user.profileNotification?.forEach((element) {
      //   print('request: ${element.type}');
      //   print('request: ${element.createdAt.toIso8601String()}');
      // });
    }
    return user;
  }

  Future<void> updateDoc(UserDB user) async {
    user.profileNotification?.forEach((element) {
      print('notyfication Id: ${element.tribeId}');
    });

    await _db.collection('USERS').doc(user.userId).update(user.toJson());
  }
}
