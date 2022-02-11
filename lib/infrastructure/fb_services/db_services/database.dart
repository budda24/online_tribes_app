import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/domain/models/user_model.dart';

final db = FirebaseFirestore.instance;

class Database {
  Future<void> createUser(UserModel user) async {
    try {
      user.createdAt = FieldValue.serverTimestamp();
      await db.collection('USERS').doc(user.id).set(user.toJson());
    } catch (e) {
      print(e);
    }
  }
}
