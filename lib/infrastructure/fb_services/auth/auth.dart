import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_1/domain/models/user_model.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/database.dart';
import 'package:get/get.dart';
import '../../../app/helpers/controllers/global_controller.dart';

final auth = FirebaseAuth.instance;

class Auth {
  final globalController = Get.find<GlobalController>();
  Future<void> logInExistingUser(UserModel user, String password) async {
    try {
      final List userEmails =
          await auth.fetchSignInMethodsForEmail(user.email ?? '');
      if (userEmails.isEmpty) {
        print("we couldn't find currant email");
      } else {
        await auth
            .signInWithEmailAndPassword(
                email: user.email ?? '', password: password)
            .then((value) {
          print(value);
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      
    }
  }

  Future<void> createUserToAuth(UserModel user, String password) async {
    try {
      final List userEmails =
          await auth.fetchSignInMethodsForEmail(user.email ?? '');
      if (userEmails.isEmpty) {
        final userCredential = await auth.createUserWithEmailAndPassword(
            email: user.email ?? '', password: password);
        print(userCredential.user!.uid);
        if (userCredential.user != null) {
          user.id = userCredential.user!.uid;
          await Database().createUser(user);
        }
      } else {
        print('Email Already Exists');
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> restPasswordEmail(String email) async {
    final response = await auth.sendPasswordResetEmail(email: email);
    return response;
    /*  .then((value) => Get.back())
        .catchError(
            (onError) => globalController.showSnackbar(onError.toString())); */
  }
}
