
import 'package:emart_app/consts/FireBase_const.dart';

class FireStoreServices {

  //get users data
  static getUser(uid){
    return firestore.collection(usersCollections).where('uid',isEqualTo: uid).snapshots();

  }


  //get products data
  static getProducts(category){
    return firestore.collection(productCollections).where('p_category',isEqualTo: category).snapshots();

  }

  ///
static getCart(uid)
{
  return firestore.collection(cartCollections).where('added_by',isEqualTo: uid).snapshots();
}

//delete doc
static deleteCart(id) {
  return firestore.collection(cartCollections).doc(id).delete();
}

//get all chat messages
static getChatMessages(docId)
{
  return firestore.collection(chatCollections).doc(docId).collection(messageCollections).orderBy('created_on',descending: false).snapshots();
}


}