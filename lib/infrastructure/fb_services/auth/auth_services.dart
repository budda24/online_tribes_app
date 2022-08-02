// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import '../../../app/controllers/global_controler.dart';
import '../../../app/helpers/theme/alert_styles.dart';
import '../../../app/modules/authorization/views/login_view.dart';
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

        if (userCredential.additionalUserInfo!.isNewUser &&
            _globalController.isCurrentUserInDB == false) {
          _globalController.hideLoading();
          Get.offAllNamed(Routes.REGISTRATION);
        } else {
          _globalController.hideLoading();

          await Get.offAllNamed(Routes.PROFILE);
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();
          _errorMessage =
              'Account already existed witch different Sign Up method ';

          _globalController.hideLoading();

          Get.off(() => LoginView());
        } else if (error.code == 'invalid-credential') {
          _errorMessage = 'Error while authorization. Please try again';

          _globalController.hideLoading();

          Get.off(() => LoginView());
        }

        showErrror(_errorMessage);

        _globalController.hideLoading();
        Get.off(() => LoginView());
      } catch (e) {
        showErrror('Error try sign in later $e');
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
      print('FirebaseAuthException');
      _globalController.hideLoading();

      showErrror(error.message!);
    } catch (error) {
      print('catch');
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

      if (userCredential.additionalUserInfo!.isNewUser &&
          _globalController.isCurrentUserInDB == false) {
        _globalController.hideLoading();
        print('is new user');

        Get.offAllNamed(Routes.REGISTRATION);
      } else {
        //TODO otherwise go to profile
        _globalController.hideLoading();
        print('go to profile');
        Get.offAllNamed(Routes.PROFILE);
      }
    } on FirebaseAuthException catch (error) {
      print('FirebaseAuthException');
      _globalController.hideLoading();

      _errorMessage = handlePhoneAuthError(error);

      showErrror(_errorMessage);
      return error;
    } catch (e) {
      print('catch');
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
      print('logout  Get.off(() => LoginView()');
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
    print('_verificationFailed');
    showErrror('Phone number verification failed because $_errorMessage');
  }

  _codeSent(String verificationId, int? forceResendingToken) async {
    _verificationId = verificationId;
    _globalController.hideLoading();
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    if (!phoneCodeSent) {
      print('_codeAutoRetrievalTimeout  Get.off(() => LoginView()');
      Get.offAll(() => LoginView());
    }
    _globalController.hideLoading();

    return null;
  }
}
