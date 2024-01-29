import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {


  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String oldPassword="" ;


  var profileImagePath = "".obs;

  final loading2 = false.obs;

  void setLoading2(bool value) => loading2.value = value;
  late String url;

  changeImage() async{
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 50);
      if (pickedFile != null) {
        profileImagePath.value = pickedFile.path;
      }else {
        return null;
      }

    } on PlatformException catch (e) {
      Utils.toastMessage(e.toString());
    }

  }



  final picker = ImagePicker();

  Future getImageFromGallery(BuildContext context) async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;


    } else {
      Utils.toastMessage("No image selected");
    }
  }

  Future getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null)
    {
      profileImagePath.value = pickedFile.path;


    } else {
      Utils.toastMessage("No image selected");
    }
  }


  uploadImage() async {
    setLoading2(true);
    var filename= basename(profileImagePath.value);
    var destination = 'images/${SessionController().userId}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    url = await ref.getDownloadURL();
    setLoading2(false);

  }

  Future<void> updateProfileWithOutImage({
    String? name,
    String? password,
    String? phoneNumber,
  }) async {
    setLoading2(true);

    try {
      // Check if the new password is different from the old password
      if (password != null && password.isNotEmpty && oldPassword != password) {
        // Update user password in Firebase Authentication
        await auth.currentUser!.updatePassword(password);
        oldPassword = password; // Update oldPassword with the new password
      }

      // Update user profile information in Firestore
      var store = firestore.collection(usersCollections).doc(SessionController().userId);
      await store.set({
        'name': name,
        'PhoneNumber': phoneNumber,
        'password': password,
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print("Profile updated successfully!");
      }
    } catch (error) {
      Utils.toastMessage("Error updating profile: $error");
    } finally {
      setLoading2(false);
    }
  }


  Future<void> updateProfileWithImage({
    String? name,
    String? password,
    String? url,
    String? phoneNumber,
  }) async {
    setLoading2(true);

    try {
      // Check if the new password is different from the old password
      if (password != null && password.isNotEmpty && oldPassword != password) {
        // Update user password in Firebase Authentication
        await auth.currentUser!.updatePassword(password);
        oldPassword = password; // Update oldPassword with the new password
      }

      // Update user profile information in Firestore
      var store = firestore.collection(usersCollections).doc(SessionController().userId);
      await store.set({
        'name': name,
        'photoUrl': url,
        'PhoneNumber': phoneNumber,
        'password': password,
      }, SetOptions(merge: true));

      if (kDebugMode) {
        print("Profile updated successfully!");
      }
    } catch (error) {
      Utils.toastMessage("Error updating profile: $error");
    } finally {
      setLoading2(false);
    }
  }

  void pickImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: lightGrey,
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: redColor),
                  title: camera.text.fontFamily(semibold).color(darkFontGrey).make(),
                  onTap: () {
                    Navigator.pop(context);
                    getImageFromCamera(context);
                  },
                ),

                ListTile(
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: const Icon(Icons.photo, color: redColor),
                  title: gallery.text.fontFamily(semibold).color(darkFontGrey).make(),
                  onTap: () {
                    Navigator.pop(context);
                    getImageFromGallery(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}