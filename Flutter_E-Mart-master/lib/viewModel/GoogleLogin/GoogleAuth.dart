// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_app/Views/HomeStructure/HomeStructureScreen.dart';
// import 'package:emart_app/consts/FireBase_const.dart';
// import 'package:emart_app/consts/consts.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import '../../WidgetCommons/HashRegenrationPassword.dart';
// import '../../utils/Utils.dart';
// import '../Services/Session manager.dart';
//
// class GoogleAuthServices {
//   final CollectionReference _usersCollection = FirebaseFirestore.instance.collection(usersCollections);
//
//   // Sign in with Google
//   Future<void> signInWithGoogle(BuildContext context) async
//   {
//     // Begin the sign-in process with interactive style
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     if (googleUser != null) {
//       // Check if the user has already registered with the same email
//       final existingUser = await _usersCollection.where("email", isEqualTo: googleUser.email).limit(1).get();
//
//       if (existingUser.docs.isNotEmpty)
//       {
//         // User already exists, log them in
//         // ... perform the login process using the existing user's data ...
//        // final userData = existingUser.docs.first.data();
//         String uid = existingUser.docs.first.id;
//
//         SessionController().userId = uid; // Set the user ID in session
//
//       } else {
//         // User doesn't exist, create a new account
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//
//         final authResult = await auth.signInWithCredential(credential);
//         String uid = authResult.user!.uid;
//
//         SessionController().userId = uid; // Set the user ID in session
//
//         String? photoUrl = googleUser.photoUrl;
//         String? userName = googleUser.displayName;
//         String additionalCredential = CredentialGenerator.generateCredential(googleUser.email);
//
//         await _usersCollection.doc(uid).set({
//
//           "uid": uid,
//           "email":googleUser.email,
//           "password": " ",
//           "name": userName ?? "No name", // Use Google user name if available, otherwise use "No name"
//           "photoUrl": photoUrl ?? "", // Use Google photo URL if available, otherwise use an empty string
//          "googleGeneratedPassword": additionalCredential, // Store the additional credential for reauthentication
//           "signInMethod": authResult.user!.providerData[0].providerId,
//           "createdOn": DateTime.now(),
//           "cart_count": "0",
//           "wishList": "0",
//           "orderCount": "0",
//           "PhoneNumber": "NO phone number",
//           // ... your user data fields ...
//         });
//
//         Utils.toastMessage("Register with Google successful");
//       }
//
//       if (context.mounted) {
//         Get.offAll(()=> const Home() ) ?.then((value)
//         {
//         }).onError((error, stackTrace) {
//           Utils.flushBarErrorMessage(error.toString(), context);
//         }); // Replace the current route with the home screen
//       }
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Views/HomeStructure/HomeStructureScreen.dart';
import 'package:emart_app/consts/FireBase_const.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../WidgetCommons/HashRegenrationPassword.dart';
import '../../utils/Utils.dart';
import '../Services/Session manager.dart';

class GoogleAuthServices {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection(usersCollections);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final existingUser = await _usersCollection.where("email", isEqualTo: googleUser.email).limit(1).get();

        if (existingUser.docs.isNotEmpty) {
          // Existing user login logic
          handleExistingUserLogin(existingUser,googleUser);
        } else {
          // New user registration logic
          await registerNewUser(googleUser);
        }

        if(context.mounted) {
          navigateToHomeScreen(context);
        }
      }
    } catch (e) {
      if(context.mounted) {
        Utils.flushBarErrorMessage("$e", context);
      }
      // Handle error appropriately
    }
  }

  void handleExistingUserLogin(QuerySnapshot existingUser,GoogleSignInAccount googleUser) async {

      String uid = existingUser.docs.first.id;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

       await FirebaseAuth.instance.signInWithCredential(credential);

        SessionController().userId = uid;


  }





  Future<void> registerNewUser(GoogleSignInAccount googleUser) async
  {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    String uid = authResult.user!.uid;

    SessionController().userId = uid;

    String? photoUrl = googleUser.photoUrl;
    String? userName = googleUser.displayName;
    String additionalCredential = CredentialGenerator.generateCredential(googleUser.email);

    await _usersCollection.doc(uid).set({
      "uid": uid,
      "email": googleUser.email,
      "password": " ",
      "name": userName ?? "No name",
      "photoUrl": photoUrl ?? "",
      "googleGeneratedPassword": additionalCredential,
      "signInMethod": authResult.user!.providerData[0].providerId,
      "createdOn": DateTime.now(),
      "cart_count": "0",
      "wishList": "0",
      "orderCount": "0",
      "PhoneNumber": "NO phone number",
    });

    Utils.toastMessage("Register with Google successful");
  }

  void navigateToHomeScreen(BuildContext context) {
    if (context.mounted) {
      Get.offAll(() => const Home())?.then((value) {
        // Handle navigation success
      }).onError((error, stackTrace) {
        Utils.flushBarErrorMessage("$error", context);
      });
    }
  }
}
