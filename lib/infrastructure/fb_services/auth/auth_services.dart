import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';
import 'package:flutter_application_1/infrastructure/fb_services/db_services/user_db_services.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import '../../../app/controllers/global_controler.dart';
import '../../../app/routes/app_pages.dart';

final User currentUser = auth.currentUser!;

final auth = FirebaseAuth.instance;

class Auth {
  bool phoneCodeSent = false;

  String _errorMessage = '';
  final _globalController = Get.find<GlobalController>();
  final _uuid = const Uuid();
  String? _verificationId;

  showErrror(String message) {
    Get.showSnackbar(customSnackbar(message));
  }

  Future<User?> signInWithGoogle() async {
    _globalController.showloading();

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

        if (userCredential.additionalUserInfo!.isNewUser) {
          _globalController.hideLoading();
          Get.offAllNamed(Routes.REGISTRATION);
        } else {
          _globalController.hideLoading();
          //TODO go to profile
         await Get.offAllNamed(Routes.PROFILE);
         /*  Get.offAllNamed(Routes.REGISTRATION); */
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();
          _errorMessage =
              'Account already existed witch different Sign Up method ';

          _globalController.hideLoading();

          Get.off(() => LoginView());
        } else if (error.code == 'invalid-credential') {
          _errorMessage =
              showErrror('Error while authorization. Please try again');

          _globalController.hideLoading();

          Get.off(() => LoginView());
          /* Get.offAllNamed(Routes.REGISTRATION); */

        }

        showErrror(_errorMessage);

        _globalController.hideLoading();
        Get.off(() => LoginView());
      } catch (e) {
        Get.showSnackbar(customSnackbar('Error try sign in later $e'));
        _globalController.hideLoading();

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

  Future<void> verifyPhoneNumber(String number) async {
    _globalController.showloading();
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: number,
          timeout: const Duration(seconds: 60),
          verificationCompleted: _verificationCompleted,
          verificationFailed: _verificationFailed,
          codeSent: _codeSent,
          codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout);
    } on FirebaseAuthException catch (error) {
      _globalController.hideLoading();

      showErrror(error.message!);
    } catch (error) {
      _globalController.hideLoading();
      print(error);
    }
  }

  Future<FirebaseAuthException?> signInWithPhoneNumber(String smsCode) async {
    _globalController.showloading();

    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: smsCode,
    );
    try {
      var userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      phoneCodeSent = true;

      if (userCredential.additionalUserInfo!.isNewUser) {
        _globalController.hideLoading();

        Get.offAllNamed(Routes.REGISTRATION);
      } else {
        //TODO otherwise go to profile
        _globalController.hideLoading();

        Get.offAndToNamed(Routes.LOGIN);
      }
    } on FirebaseAuthException catch (error) {
      _globalController.hideLoading();

      _errorMessage = handlePhoneAuthError(error);

      showErrror(_errorMessage);
      return error;
    } catch (e) {
      _globalController.hideLoading();

      print(e.toString());
    }
    return null;
  }

  Future<void> logout() async {
    _globalController.showloading();
    try {
      await auth.signOut();

      _globalController.hideLoading();

      Get.off(() => LoginView());
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  _verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await auth.signInWithCredential(phoneAuthCredential);
    _globalController.hideLoading();
  }

  _verificationFailed(FirebaseAuthException error) {
    _errorMessage = handlePhoneAuthError(error);
    showErrror('Phone number verification failed because $_errorMessage');
  }

  _codeSent(String verificationId, int? forceResendingToken) async {
    _verificationId = verificationId;
    _globalController.hideLoading();
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    if (!phoneCodeSent) {
      Get.offAll(() => LoginView());
    }
    _globalController.hideLoading();

    return null;
  }
}
