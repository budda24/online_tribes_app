import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/app/helpers/theme/alert_styles.dart';
import 'package:flutter_application_1/app/modules/authorization/views/login_view.dart';
import 'package:flutter_application_1/app/modules/registration/views/registration_desrription_view.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app/controllers/global_controler.dart';
import '../../../app/routes/app_pages.dart';

final auth = FirebaseAuth.instance;
User? user;

class Auth {
  final globalController = Get.find<GlobalController>();

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
        user = userCredential.user;


        /* globalController.box.remove(user!.uid); */
        // await db.createUser(user!);

        globalController.hideLoading();

        // Get.offAndToNamed(Routes.PROFIL);
        Get.to(() => const RegistrationDescriptionView());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          await googleSignIn.signOut();

          Get.showSnackbar(customSnackbar(
              'Account already existed witch different Sign Up method '));

          globalController.hideLoading(); //switch to false

          Get.off(() => LoginView());
        } else if (e.code == 'invalid-credential') {
          Get.showSnackbar(customSnackbar(' Invalid a '));

          globalController.hideLoading();

          Get.offAllNamed(Routes.REGISTRATION);
        }
      } catch (e) {
        Get.showSnackbar(customSnackbar('Error try siign in later'));
      }
    }
    return null;
  }
}
