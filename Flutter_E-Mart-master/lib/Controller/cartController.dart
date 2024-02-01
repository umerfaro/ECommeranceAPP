import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/HomeContoller.dart';
import 'package:get/get.dart';

import '../consts/consts.dart';

class CartController extends GetxController {

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var phoneController = TextEditingController();
  var zipCodeController = TextEditingController();

  final FocusNode addressFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode zipCodeFocus = FocusNode();

  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();


  var totalPrice = 0.0.obs;
  var paymentIndex = 0.obs;

  var placingOrder=false.obs;

  var vendors = [];

  var checkCartEmpty = false;

  changePaymentIndex(int index) {
    paymentIndex.value = index;
  }

  calculate(data) {
    totalPrice.value = 0.0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value = totalPrice.value + double.parse(data[i]['totalPrice'].toString());
    }
  }

  late dynamic productSnapshot;
  var products = [];
  
  placeMyOrder({required orderPaymentMethod, required totalPrice}) async
  {
    placingOrder(true);
   await getProductDetails();
    await firestore.collection(orderCollections).doc().set({
      'order_code': 'EMART-${DateTime.now().millisecondsSinceEpoch}',
      'order_by': currentUser!.uid,
      'order_date': FieldValue.serverTimestamp(),
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_phone': phoneController.text,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_zipCode': zipCodeController.text,
      'shipping_method': "Home delivery",
      'payment_method': orderPaymentMethod,
      'order_placed':true,
      'total_price': totalPrice,
      'orders':  FieldValue.arrayUnion(products),
      'order_confirmation': false,
      'order_delivered': false,
      'order_on_the_way': false,
      'vendors': FieldValue.arrayUnion(vendors),

    });
    placingOrder(false);
    
  }

  getProductDetails(){
    products.clear();
    vendors.clear();
    for(var i=0;i<productSnapshot.length;i++){

      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'totalPrice':productSnapshot[i]['totalPrice'],
      });
      
      vendors.add(productSnapshot[i]['vendor_id']);
      

    }

  }

//clear all products for the cart
  clearCart()
  {

      for(var i=0;i<productSnapshot.length;i++)
      {
        firestore.collection(cartCollections).doc(productSnapshot[i].id).delete();
      }

  }


}
