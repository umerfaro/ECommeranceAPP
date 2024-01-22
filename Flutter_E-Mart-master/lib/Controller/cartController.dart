import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.0.obs;

  calculate(data) {
    totalPrice.value = 0.0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value = totalPrice.value + double.parse(data[i]['totalPrice'].toString());
    }
  }
}
