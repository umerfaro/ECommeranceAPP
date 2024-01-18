import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Views/HomeStructure/HomeStructureScreen.dart';
import 'package:emart_app/consts/FireBase_const.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/Utils.dart';
import '../Services/Session manager.dart';

class GoogleAuthServices {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection(usersCollections);

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async
  {
    // Begin the sign-in process with interactive style
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Check if the user has already registered with the same email
      final existingUser = await _usersCollection.where("email", isEqualTo: googleUser.email).limit(1).get();

      if (existingUser.docs.isNotEmpty) {
        // User already exists, log them in
        // ... perform the login process using the existing user's data ...
       // final userData = existingUser.docs.first.data();
        String uid = existingUser.docs.first.id;
        print("Hello");
        print(uid.toString());
        SessionController().userId = uid; // Set the user ID in session

      } else {
        // User doesn't exist, create a new account
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        String uid = authResult.user!.uid;
        print("Hello1");
        print(uid.toString());

        SessionController().userId = uid; // Set the user ID in session

        await _usersCollection.doc(uid).set({

          "uid": uid,
          "email":googleUser.email,
          "password": " ",
          "name": " ",
          "photoUrl": " ",
          "signInMethod": authResult.user!.providerData[0].providerId,
          "createdOn": DateTime.now(),
          // ... your user data fields ...
        });

        Utils.toastMessage("Register with Google successful");
      }

      if (context.mounted) {
        Get.offAll(()=> const Home() ) ?.then((value)
        {
        }).onError((error, stackTrace) {
          Utils.flushBarErrorMessage(error.toString(), context);
        }); // Replace the current route with the home screen
      }
    }
  }
}
