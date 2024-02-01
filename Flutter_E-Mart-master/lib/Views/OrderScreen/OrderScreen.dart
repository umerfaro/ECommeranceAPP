import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';
import 'package:get/get.dart';

import '../../WidgetCommons/LoadingIndicator.dart';
import 'orderDetails.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Orders".text.color(redColor).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getOrders(
                SessionController().userId.toString()),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Orders Yet!"
                    .text
                    .size(20)
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: "${index + 1}"
                            .text
                            .xl
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),
                        title: data[index]['order_code']
                            .toString()
                            .text
                            .size(18)
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['total_price']
                            .toString()
                            .numCurrency
                            .text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: darkFontGrey,
                          ),
                          onPressed: () {
                            Get.to(OrderDetails(data: data[index]));
                          },
                        ),
                      );
                    });
              }
            }));
  }
}
