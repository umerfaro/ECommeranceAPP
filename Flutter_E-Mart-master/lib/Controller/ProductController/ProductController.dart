import 'dart:convert';

import 'package:emart_app/Services/Category_Model.dart';
import 'package:emart_app/Services/Category_Model.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';



class ProductController extends GetxController{

  var subcat=[];

  getSubCat(title) async {
   subcat.clear();


   var data =await rootBundle.loadString("lib/Services/category_model.json");

   var decoded= categoryModel.fromJson(json.decode(data));

    var s= decoded.categories!.where((element) => element.name==title).toList();

    for( var e in s[0].subcategory!){
      subcat.add(e);
    }



  }


}