
import 'package:emart_app/consts/FireBase_const.dart';
import 'package:emart_app/consts/consts.dart';

class FireStoreServices {

  //get users data
  static getUser(uid){
    return firestore.collection(usersCollections).where('uid',isEqualTo: uid).snapshots();

  }


  //get products data
  static getProducts(category){
    return firestore.collection(productCollections).where('p_category',isEqualTo: category).snapshots();

  }

  //set sub category

  static getSubCategoires(title)
  {
    return firestore.collection(productCollections).where('p_subcategory',isEqualTo: title).snapshots();
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

//get all orders
static getOrders(uid) {
  return firestore.collection(orderCollections).where(
      'order_by', isEqualTo: uid).snapshots();
}

//get wish list
static getWishList(uid) {
  return firestore.collection(productCollections).where(
      'p_wishList', arrayContains: uid).snapshots();
}

//get all messages
static getAllMessages(uid) {
  return firestore.collection(chatCollections).where("fromId",isEqualTo: uid).snapshots();
}

//get counts
  //get all counts details at ones in a list
  //filters
static getCounts(uid) async {
var res= await Future.wait([
  firestore.collection(cartCollections).where('added_by',isEqualTo: uid).get().then((value) {
    return value.docs.length;
  }),
    firestore.collection(productCollections).where(
  'p_wishList', arrayContains: uid).get().then((value) {
    return value.docs.length;
  }),
  firestore.collection(orderCollections).where('order_by',isEqualTo: uid).get().then((value) {
    return value.docs.length;
  }),

]);
return res;

  }



  //get all prodocts
static getAllProducts() {
  return firestore.collection(productCollections).snapshots();
}


//get featured products
static getFeaturedProducts() {
  return firestore.collection(productCollections).where(
      'is_featured', isEqualTo: true).snapshots();
}

//get search products
static getSearchProducts(searchText) {
  return firestore.collection(productCollections).get();
}



}