import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Services/Category_Model.dart';
import 'package:emart_app/consts/consts.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Utils/Utils.dart';



class ProductController extends GetxController{

  var quantity=0.obs;
var colorIndex=0.obs;
var totalPrice=0.obs;
var isFavorite=false.obs;

var loading=false.obs;
  void setLoading2(bool value) => loading.value = value;

  var subCat=[];

  getSubCat(title) async {
   subCat.clear();


   var data =await rootBundle.loadString("lib/Services/category_model.json");

   var decoded= categoryModel.fromJson(json.decode(data));

    var s= decoded.categories!.where((element) => element.name==title).toList();

    for( var e in s[0].subcategory!){
      subCat.add(e);
    }




  }

  calculateTotalPrice(price)
  {
    totalPrice.value=price * quantity.value;
  }


  changeColorIndex(index){
    colorIndex.value=index;
  }

  increment(totalQuantity){
    if(quantity.value<totalQuantity) {
      quantity.value++;
    }
  }
  decrement(){
    if(quantity.value>0) {
      quantity.value--;
    }
  }

  addToCart({
    required String title,
    required String img,
    required String sellerName,
    required int qty,
    required double totalPrice, required color,
    required vender_id
  }) async {
    setLoading2(true);
    if (currentUser != null) {
      await firestore.collection(cartCollections).doc().set({
        "title": title,
        "img": img,
        "sellerName": sellerName,
        "qty": qty,
        "totalPrice": totalPrice,
        "added_by": currentUser!.uid,
        "color": color,
        "vendor_id":vender_id,
      }).then((value) {
        Utils.toastMessage("Added to cart");
        setLoading2(false);
        resetValues();
      }).catchError((error) {
        Utils.toastMessage(error.toString());
        setLoading2(false);
      });
    } else {
      Utils.toastMessage("User not logged in");
      setLoading2(false);
    }
  }

resetValues() {
  quantity.value = 0;
  colorIndex.value = 0;
  totalPrice.value = 0;
}


addToWishList(docID) async{

    await firestore.collection(productCollections).doc(docID).set({
   'p_wishList':FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));

    isFavorite.value=true;
    Utils.toastMessage("Added to wishList");
}

  removeToWishList(docID) async{

    await firestore.collection(productCollections).doc(docID).set({
      'p_wishList':FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));

    isFavorite.value=false;
    Utils.toastMessage("Removed from wishList");

  }

  checkIfProductIsFavorite(data) async
  {
    if(data['p_wishList'].contains(currentUser!.uid)){
      isFavorite.value=true;
    }else{
      isFavorite.value=false;
    }
  }


}