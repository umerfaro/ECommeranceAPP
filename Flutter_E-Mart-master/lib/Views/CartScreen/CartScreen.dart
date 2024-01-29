import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Views/CartScreen/shippin_screen.dart';
import 'package:emart_app/WidgetCommons/LoadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Controller/cartController.dart';
import '../../Utils/Utils.dart';
import '../../WidgetCommons/CustomButton.dart';
import '../../viewModel/Services/FireStoreServices.dart';
import '../../viewModel/Services/Session manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CartScreen> {
  var cartC = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: SizedBox(
          width: context.screenWidth - 40,
          child: customButtonWidget(
            onPress: () {
              if (cartC.checkCartEmpty == true) {
                Utils.toastMessage(
                    "Cart is Empty. Please add some products to continue");
              } else {
                Get.to(() => const ShippingDetails());
              }
            },
            title: "Checkout",
            textColor: whiteColor,
            color: redColor,
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          title: cart.text
              .size(20)
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getCart(SessionController().userId.toString()),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              cartC.checkCartEmpty = false;
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              cartC.checkCartEmpty = true;

              return Container(
                color: whiteColor,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 100.0,
                        backgroundImage: AssetImage(emptyCart),
                      ),
                      20.heightBox,
                      cartEmpty.text
                          .size(20)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      20.heightBox,
                      cartEmptyMsg.text
                          .size(14)
                          .fontFamily(semibold)
                          .align(TextAlign.center)
                          .color(darkFontGrey)
                          .make(),
                    ]),
              );
            } else if (snapshot.hasData) {
              cartC.checkCartEmpty = false;
              var data = snapshot.data!.docs;
              cartC.calculate(data);
              cartC.productSnapshot = data;
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(
                              16.0), // Adjust padding as needed
                          tileColor: Colors.white, // Set the background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Set border radius
                            side: BorderSide(
                                color: Colors.grey[300]!), // Set border color
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Set border radius for the image
                            child: Image.network(
                              data[index]['img'].toString(),
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data[index]['title']
                                  .toString()
                                  .text
                                  .size(16)
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              const SizedBox(
                                  height:
                                      8.0), // Add some spacing between title and quantity
                              Text(
                                'Quantity: ${data[index]['qty']}', // Assuming 'quantity' is the key for quantity in your data
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: regular,
                                  color: darkFontGrey,
                                ),
                              ),
                            ],
                          ),
                          subtitle: data[index]['totalPrice']
                              .toString()
                              .numCurrency
                              .text
                              .size(14)
                              .fontFamily(regular)
                              .color(redColor)
                              .make(),
                          trailing: IconButton(
                            onPressed: () {
                              FireStoreServices.deleteCart(data[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: redColor,
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price"
                        .text
                        .size(14)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    Obx(() => cartC.totalPrice.value.numCurrency.text
                        .size(14)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make()),
                  ],
                )
                    .box
                    .padding(const EdgeInsets.all(12))
                    .color(lightGolden)
                    .width(context.screenWidth - 60)
                    .roundedSM
                    .make(),
                10.heightBox,

              ]);
            } else {
              return Container();
            }
          },
        ));
  }
}
