
import 'package:emart_app/consts/FireBase_const.dart';

class FireStoreServices {

  //get users data
  static getUser(uid){
    return firestore.collection(usersCollections).where('uid',isEqualTo: uid).snapshots();

  }

}