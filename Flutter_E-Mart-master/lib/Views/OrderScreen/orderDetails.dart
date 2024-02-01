import 'package:emart_app/Views/OrderScreen/Components/OrderPlaced.dart';
import 'package:emart_app/consts/consts.dart';

import 'Components/orderStatus.dart';
import "package:intl/intl.dart" as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            centerTitle: true,
            title: "Order Details".text.color(redColor).fontFamily(bold).make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  orderStatus(
                      icon: Icons.check_circle,
                      color: redColor,
                      title: "Placed",
                      showDone: data["order_placed"]),
                  orderStatus(
                      icon: Icons.thumb_up,
                      color: Colors.blue,
                      title: "Confirmed",
                      showDone: data["order_confirmation"]),
                  orderStatus(
                      icon: Icons.car_crash,
                      color: Colors.yellow,
                      title: "Delivery",
                      showDone: data["order_on_the_way"]),
                  orderStatus(
                      icon: Icons.done_all_rounded,
                      color: Colors.purple,
                      title: "Delivered",
                      showDone: data["order_delivered"]),
                  const Divider(),
                  10.heightBox,
                  Column(
                    children: [
                      orderPlaced(
                          title1: "Order Code",
                          title2: "Shipping Method",
                          detail1: data["order_code"].toString(),
                          detail2: data["shipping_method"].toString()),
                      orderPlaced(
                          title1: "Order Date",
                          title2: "Payment Method",
                          detail1: intl.DateFormat()
                              .add_yMd()
                              .format(data["order_date"].toDate())
                              .toString(),
                          detail2: data["payment_method"].toString()),
                      orderPlaced(
                          title1: "Payment Status",
                          title2: "Delivery Status",
                          detail1: "Unpaid",
                          detail2: "Order Placed"),
                      const Divider(),
                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Shipping Address"
                                      .text
                                      .color(darkFontGrey)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make(),
                                  "Name: ${data["order_by_name"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "Email: ${data["order_by_email"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "Address: ${data["order_by_address"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "City: ${data["order_by_city"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "State: ${data["order_by_state"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "ZipCode :${data["order_by_zipCode"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                  "Phone number: ${data["order_by_phone"]}"
                                      .text
                                      .size(10)
                                      .make(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total Amount"
                                      .text
                                      .size(12)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                  "RS. ${data["total_price"]}"
                                      .text
                                      .color(redColor)
                                      .make(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ).box.outerShadowMd.white.make(),
                  10.heightBox,
                  "Order Product"
                      .text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .make(),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true, //becase we are in coloumn
                    children: List.generate(data["orders"].length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaced(
                              title1: data["orders"][index]["title"],
                              title2: data["orders"][index]["totalPrice"]
                                  .toString(),
                              detail1:
                                  "${data["orders"][index]["qty"]}x".toString(),
                              detail2: "Refundable"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 10,
                              color: Color(data["orders"][index]["color"]),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  )
                      .box
                      .outerShadowMd
                      .white
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                  10.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          "Subtotal"
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          const Spacer(),
                          "RS. ${data["total_price"]}"
                              .text
                              .color(redColor)
                              .make(),
                        ],
                      ),
                      Row(
                        children: [
                          "Tax"
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          const Spacer(),
                          "Null".text.color(redColor).make(),
                        ],
                      ),
                      Row(
                        children: [
                          "Discount"
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          const Spacer(),
                          "Null".text.color(redColor).make(),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          "Grand Total "
                              .text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(bold)
                              .make(),
                          const Spacer(),
                          "RS. ${data["total_price"]}"
                              .text
                              .color(redColor)
                              .make(),
                        ],
                      ),
                    ],
                  ),
                  20.heightBox,
                ],
              ),
            ),
          )),
    );
  }
}
