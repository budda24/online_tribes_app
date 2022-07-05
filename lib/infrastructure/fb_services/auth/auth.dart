import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/database.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import '../../../app/controllers/global_controler.dart';
import '../../../app/routes/app_pages.dart';
import '../models/user_model.dart';

final auth = FirebaseAuth.instance;

Database db = Database();

class Auth {
  final _uuid = const Uuid();
  final globalController = Get.find<GlobalController>();

  String errorMessage = '';

  showErrror(String message) {
    Get.showSnackbar(customSnackbar(message));
  }

  Future<User?> signInWithGoogle() async {
    globalController.showloading();

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        // TODO create a user in Db
        final user = auth.currentUser;
        final userToSave = UserDB(userId: user!.uid, email: user.email);
        try {
          print('try to save user');
          await UserDBServices().createUser(userToSave);
        } catch (error) {
          print(error);
        }

        globalController.hideLoading();
        //TODO go to profile
        // Get.offAndToNamed(Routes.PROFIL);
        Get.to(() => RegistrationDescriptionView());
      } on FirebaseAuthException catch (error) {
        if (error.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();
          errorMessage =
              'Account already existed witch different Sign Up method ';

          globalController.hideLoading();

          Get.off(() => LoginView());
        } else if (error.code == 'invalid-credential') {
          errorMessage =
              showErrror('Error while authorization. Please try again');

          globalController.hideLoading();

          Get.offAllNamed(Routes.REGISTRATION);
        }

        showErrror(errorMessage);
        globalController.hideLoading();
        Get.off(() => LoginView());
      } catch (e) {
        Get.showSnackbar(customSnackbar('Error try sign in later $e'));
        globalController.hideLoading();
        Get.off(() => LoginView());
      }
    }
    return null;
  }

  String handlePhoneAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-verification-code':
        return 'Invalid Code, please try again';
      default:
        return error.message!;
    }
  }

  _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await auth.signInWithCredential(phoneAuthCredential);
    globalController.hideLoading();
  }

  _verificationFailed(FirebaseAuthException error) {
    errorMessage = handlePhoneAuthError(error);
    showErrror('Phone number verification failed because $errorMessage');
  }

  String? _verificationId;

  _codeSent(String verificationId, int? forceResendingToken) async {
    _verificationId = verificationId;
    globalController.hideLoading();
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    Get.offAll(() => LoginView());
    globalController.hideLoading();

    return null;
  }

  Future<void> verifyPhoneNumber(String number) async {
    globalController.showloading();
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: _verificationCompleted,
          verificationFailed: _verificationFailed,
          codeSent: _codeSent,
          codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (error) {
      globalController.hideLoading();

      showErrror(error.message!);
    } catch (error) {
      globalController.hideLoading();
      print(error);
    }
  }

  Future<FirebaseAuthException?> signInWithPhoneNumber(String smsCode) async {
    globalController.showloading();

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    try {
      await auth.signInWithCredential(credential).then((response) {
        Get.to(() => RegistrationDescriptionView());
        // TODO create a user in Db
        User? _user = response.user;
        globalController.hideLoading();
      });
      print(auth.currentUser);
    } on FirebaseAuthException catch (error) {
      globalController.hideLoading();
      errorMessage = handlePhoneAuthError(error);
      print('signInWithCredential error');
      showErrror(errorMessage);
      return error;
    } catch (e) {
      /* print('catch after rethorw'); */
      globalController.hideLoading();
      print(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    globalController.showloading();
    try {
      await auth.signOut();
      globalController.hideLoading();
      Get.off(() => LoginView());
    } on FirebaseException catch (error) {
      print(error);
    }
  }
}
