import 'package:cached_network_image/cached_network_image.dart';

import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Utils/Utils.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  var productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // Handle back button press
        // Handle back button press
        if (didPop) {
          //SystemNavigator.pop();
          return;
        }
        productController.resetValues();
        Get.back();
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
                productController.resetValues();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: widget.title!.text.white
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SwiperSection

                    VxSwiper.builder(
                      viewportFraction: 1.0,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 350,
                      itemCount: widget.data['p_images'].length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: widget.data["p_images"][index],
                          width: double.infinity,
                          fit: BoxFit.fill,
                        )
                            .box
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 2))
                            .make();
                      },
                    ),
                    10.heightBox,
                    //Title
                    widget.title!.text
                        .size(16)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    //rating

                    Row(
                      children: [
                        VxRating(
                          value:
                              double.parse(widget.data['p_rating'].toString()),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          size: 20,
                          count: 5,
                          maxRating: 5,
                          isSelectable:
                              false, // Set this to false to make the rating fixed
                        ),
                        5.widthBox,
                        widget.data['p_rating']
                            .toString()
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                      ],
                    ),
                    10.heightBox,
                    //Price
                    "${widget.data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Seller".text.fontFamily(bold).make(),
                                "${widget.data['p_seller']}"
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              ],
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .color(textfieldGrey)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make(),
                    10.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color:"
                                    .text
                                    .white
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                              Row(
                                children: List.generate(
                                    widget.data['p_colors'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        widget.data['p_colors']
                                                            [index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              productController
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                                visible: index ==
                                                    productController
                                                        .colorIndex.value,
                                                child: const Icon(
                                                  Icons.check,
                                                  color: whiteColor,
                                                )),
                                          ],
                                        )),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          // quantity
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity:"
                                    .text
                                    .white
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          productController.decrement();
                                          productController.calculateTotalPrice(
                                              int.parse(
                                                  widget.data['p_price']));
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: darkFontGrey,
                                        )),
                                    productController.quantity.value.text
                                        .size(16)
                                        .white
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          productController.increment(int.parse(
                                              widget.data['p_quantity']));
                                          productController.calculateTotalPrice(
                                              int.parse(
                                                  widget.data['p_price']));
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: darkFontGrey,
                                        )),
                                    "(${widget.data['p_quantity']} available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ],
                                ),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //total price
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total:"
                                    .text
                                    .white
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                              Row(
                                children: [
                                  "${productController.totalPrice.value}"
                                      .numCurrency
                                      .text
                                      .size(16)
                                      .white
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              ),

                              //description
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    10.heightBox,
                    "Description"
                        .text
                        .white
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,

                    "${widget.data['p_description']}"
                        .text
                        .white
                        .color(darkFontGrey)
                        .make(),
                    10.heightBox,
                    //butoon section

                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          listOfDetails.length,
                          (index) => ListTile(
                                title: listOfDetails[index]
                                    .text
                                    .white
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.arrow_forward,
                                  color: darkFontGrey,
                                ),
                              )),
                    ),
                    //
                    10.heightBox,
                    productYouMayLike.text.white
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .size(16)
                        .make(),
                    20.heightBox,

                    //Featured Product may like
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                featuredProductList[index],
                                width: 100,
                                height: 100,
                              ),
                              10.heightBox,
                              featuredProductTitle[index]
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              featuredProductPrice[index]
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(8))
                              .roundedSM
                              .make(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Hero(
                        tag:
                            'AddToCart_button', // Unique tag for AddToCart_button
                        child: customButtonWidget(
                          loading: productController.loading.value,
                          onPress: () {
                            if (productController.quantity.value > 0) {
                              productController.addToCart(
                                color: widget.data['p_colors']
                                    [productController.colorIndex.value],
                                qty: productController.quantity.value,
                                img: widget.data['p_images'][0],
                                title: widget.data['p_name'],
                                totalPrice: double.parse(productController
                                    .totalPrice.value
                                    .toString()),
                                sellerName: widget.data['p_seller'],
                              );
                            } else {
                              Utils.toastMessage("Please select quantity");
                              productController.setLoading2(false);
                            }
                          },
                          title: "Add to Cart",
                          textColor: whiteColor,
                          color: redColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Hero(
                        tag: 'BuyNow_button', // Unique tag for BuyNow_button
                        child: customButtonWidget(
                          onPress: () {},
                          title: "Buy Now",
                          textColor: whiteColor,
                          color: darkFontGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
