import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';

class ItemDetails extends StatefulWidget {
  final String? title;
  final String? image;
  final String? price;
  const ItemDetails(
      {super.key, required this.title, this.image, required this.price});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: widget.title!.text.white
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //SwiperSection

                                VxSwiper.builder(
                                  aspectRatio: 16 / 9,
                                  autoPlay: true,
                                  autoPlayAnimationDuration: 1.seconds,
                                  height: 300,
                                  itemCount: sliderList.length,
                                  itemBuilder: (context, index) {
                                    return Image.asset(
                                      sliderList[index],
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                        .box
                                        .clip(Clip.antiAlias)
                                        .margin(EdgeInsets.symmetric(horizontal: 2))
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
                                      onRatingUpdate: (value) {},
                                      normalColor: textfieldGrey,
                                      selectionColor: golden,
                                      size: 20,
                                      stepInt: true,
                                      count: 5,
                                      //isSelectable: false, // Set this to false to make the rating fixed
                                    ),
                                    5.widthBox,
                                    "(4)"
                                        .text
                                        .size(12)
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                  ],
                                ),
                                10.heightBox,
                                //Price
                                widget.price!.text.color(redColor).fontFamily(bold).make(),
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
                                            "In house Brands"
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
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child:
                                              "Color:".text.white.color(darkFontGrey).make(),
                                        ),
                                        Row(
                                          children: List.generate(
                                              3,
                                              (index) => VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Vx.randomPrimaryColor)
                                                  .margin(EdgeInsets.symmetric(horizontal: 6))
                                                  .make()),
                                        )
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
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: darkFontGrey,
                                                )),
                                            "0"
                                                .text
                                                .size(16)
                                                .white
                                                .color(darkFontGrey)
                                                .fontFamily(bold)
                                                .make(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                  color: darkFontGrey,
                                                )),
                                          ],
                                        )
                                      ],
                                    ).box.padding(const EdgeInsets.all(8)).make(),
                                    //total price
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child:
                                              "Total:".text.white.color(darkFontGrey).make(),
                                        ),
                                        Row(
                                          children: [
                                            "\$0.00"
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
                                10.heightBox,
                                "Description".text.white.color(darkFontGrey).fontFamily(bold).make(),
                                10.heightBox,
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget fermentum aliquam, leo nisl vestibulum nisl, eget aliquam nisl nisl eget augue. Donec euismod, nisl eget fermentum aliquam, leo nisl vestibulum nisl, eget aliquam nisl nisl eget augue."
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'AddToCart_button', // Unique tag for AddToCart_button
                    child: customButtonWidget(
                      onPress: () {},
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
          )
        ],
      ),
    );
  }
}
