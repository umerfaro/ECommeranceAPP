
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int loginAttempts = 0;
  final RxBool isChecked = false.obs;
  final RxBool loginButtonEnable = false.obs;
  final RxBool signButtonEnable = false.obs;

  final RxBool isGoogleSignInLoading = false.obs;

  Map<String, int> emailLoginAttempts = {};

  void resetCheckboxState() {
    isChecked.value = false;
  }

  void resetLoginState() {
    loginButtonEnable.value = false;
  }

  Future<UserCredential?> loginMethod() async {
    try {
      loginButtonEnable.value = true;

      // Check if there are too many login attempts for this email
      if ((emailLoginAttempts[emailController.text] ?? 0) >= 3) {
        loginButtonEnable.value = false;
        Utils.toastMessage("Too many login attempts. Your account is temporarily blocked.");
        return null;
      }

      final userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Reset login attempts for this email on successful login
      emailLoginAttempts[emailController.text] = 0;

      SessionController().userId = userCredential.user!.uid;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Increment login attempts for this email
      emailLoginAttempts[emailController.text] = (emailLoginAttempts[emailController.text] ?? 0) + 1;

      // Check if there are too many login attempts for this email
      if ((emailLoginAttempts[emailController.text] ?? 0) >= 3) {
        loginButtonEnable.value = false;
        Utils.toastMessage("Too many login attempts. Your account is temporarily blocked.");
        return null;
      }

      Utils.toastMessage(_handleLoginError(e));
      loginButtonEnable.value = false;
    } finally {
      loginButtonEnable.value = false;
    }
    return null;
  }





  Future<void> signUp(BuildContext context, String username, String email, String password) async {
    try {
      signButtonEnable.value = true;
      final authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);

      await storeUserData(
        name: username,
        email: email,
        password: password,
        authResult: authResult, // Pass the authResult
      );

      Utils.toastMessage("Account Created Successfully");
      if (context.mounted)
      {
        Get.back();
        resetCheckboxState();
      }
    } on FirebaseAuthException catch (e) {
      Utils.toastMessage(_handleSignUpError(e));
    } finally {
      signButtonEnable.value = false;
    }
  }

  Future<void> storeUserData({
    required String name,
    required String email,
    required String password,
    required UserCredential authResult, // Receive authResult as a parameter
  }) async {
    final store = firestore.collection(usersCollections).doc(authResult.user!.uid);
    await store.set({
      "uid": authResult.user!.uid,
      "email": email,
      "password": password,
      "name": name,
      "photoUrl": " ",
      "signInMethod": authResult.user!.providerData[0].providerId,
      "createdOn": DateTime.now(),
    });
  }

  Future<void> signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      Utils.toastMessage(e.toString());
    }
  }

  String _handleLoginError(FirebaseAuthException e) {
    // Log the error code for debugging purposes
    if (kDebugMode) {
      print("Firebase Authentication Error Code: ${e.code}");
    }

    switch (e.code) {
      case 'too-many-requests':
        return 'Too many login attempts. Your account is temporarily blocked.';
      case 'user-not-found':
        return 'No user found for that email';
      case 'wrong-password':
        return 'Wrong password provided for that user';
      default:
        return e.message ?? 'An error occurred during login';
    }
  }



  String _handleSignUpError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email';
      case 'wrong-password':
        return 'Wrong password provided for that user';
      case 'email-already-in-use':
        return 'The email address is already in use by another account';
      case 'invalid-email':
        return 'The email address is badly formatted';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'weak-password':
        return 'The password is too weak';
      default:
        return e.message ?? 'An error occurred during sign-up';
    }
  }

}
