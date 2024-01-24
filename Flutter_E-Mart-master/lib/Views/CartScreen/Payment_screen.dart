import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/Views/HomeStructure/HomeStructureScreen.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Controller/cartController.dart';
import '../../WidgetCommons/CustomButton.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var paymentController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Payment Methods"
            .text
            .size(20)
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: Obx(
        ()=> SizedBox(
          width: context.screenWidth - 40,
          child: customButtonWidget(
            loading: paymentController.placingOrder.value,
            onPress: () {

              paymentController.placeMyOrder(
                  orderPaymentMethod: paymentList[paymentController.paymentIndex.value],
                  totalPrice: paymentController.totalPrice.value
              ).then((value) async {
                await paymentController.clearCart();
                Utils.toastMessage("product placed successfully");
                Get.offAll(() => const Home());
                paymentController.placingOrder(false);
              }).catchError((e) {
                Utils.toastMessage(e.toString());
                paymentController.placingOrder(false);
              });


            },
            title: "Place my order",
            textColor: whiteColor,
            color: redColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(
          ()=> Column(
            children: List.generate(paymentImageList.length, (index) {
              return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color:  paymentController.paymentIndex.value == index ?redColor: Colors.transparent,
                        width: 5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentImageList[index],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        colorBlendMode:paymentController.paymentIndex.value == index? BlendMode.darken:BlendMode.srcOver,
                        color: paymentController.paymentIndex.value == index?Colors.black.withOpacity(0.4):Colors.transparent,
                      ),

                      paymentController.paymentIndex.value == index ? Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                          activeColor: green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),

                            value: true, onChanged: (value){

                        }),
                      ):Container(),
                      Positioned(
                        bottom: 10,
                          right: 10,
                          child: paymentList[index].text.white.fontFamily(semibold).size(16).make()),
                    ],
                  )).onTap(() {

                    paymentController.changePaymentIndex(index);

              });
            }),
          ),
        ),
      ),
    );
  }
}
