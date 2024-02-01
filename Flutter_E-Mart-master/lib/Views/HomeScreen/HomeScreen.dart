import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Views/CategoryScreen/ItemDetails.dart';
import 'package:emart_app/Views/HomeScreen/Components/Featursbuttons.dart';
import 'package:emart_app/WidgetCommons/HomeButtons.dart';
import 'package:emart_app/WidgetCommons/LoadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/HomeContoller.dart';
import '../../Controller/ProductController/ProductController.dart';
import '../../consts/List.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var categoryController = Get.put(ProductController());
  var homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(children: [
        Container(
          alignment: Alignment.center,
          height: 60,
          color: lightGrey,
          child: TextFormField(
            controller: homeController.searchController,
            decoration: InputDecoration(
              hintText: search,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                fontFamily: semibold,
                color: textfieldGrey,
              ),
              suffixIcon: const Icon(Icons.search).onTap(() {
                if (homeController.searchController.text.isNotEmptyAndNotNull) {
                  Get.to(() => SearchScreen(
                        search: homeController.searchController.text,
                      ));
                }
              }),
              filled: true,
              fillColor: whiteColor,
            ),
          ),
        ),
        20.heightBox,
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //swapperBrandlist
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayAnimationDuration: 1.seconds,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: sliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      sliderList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(EdgeInsets.symmetric(horizontal: 8))
                        .make();
                  },
                ),
                20.heightBox,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todayDeals : flashSale,
                              onPress: () {},
                            ))),
                20.heightBox,
                //secondSliderList
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayAnimationDuration: 1.seconds,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: secondSliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      secondSliderList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(EdgeInsets.symmetric(horizontal: 8))
                        .make();
                  },
                ),
                20.heightBox,
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 3.2,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brands
                                      : topSeller,
                              onPress: () {},
                            ))),
                //fetured categories
                20.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make()),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Column(
                              children: [
                                featuredButton(
                                    images: featuredListUpper[index],
                                    title: featuredListUpperTitle[index],
                                    categoryController: categoryController),
                                10.heightBox,
                                featuredButton(
                                    images: featuredListLower[index],
                                    title: featuredListLowerTitle[index],
                                    categoryController: categoryController),
                              ],
                            )).toList(),
                  ),
                ),
                20.heightBox,
                //featured product
                Stack(
                  children: [
                    // Background image
                    Positioned.fill(
                      child: Image.asset(
                        imgFe,
                        fit: BoxFit
                            .cover, // or BoxFit.fill, depending on your requirement
                      ),
                    ),

                    // Content on top of the background image
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: StreamBuilder(
                                stream: FireStoreServices.getFeaturedProducts(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(child: loadingIndicator());
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: "No Featured Products Today"
                                          .text
                                          .white
                                          .fontFamily(semibold)
                                          .make(),
                                    );
                                  } else {
                                    var data = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                        data.length,
                                        (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: data[index]['p_images']
                                                  [0],
                                              width: 100,
                                              height: 100,
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: loadingIndicator(),
                                              ),
                                            ),
                                            10.heightBox,
                                            data[index]['p_name']
                                                .toString()
                                                .text
                                                .white
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                            10.heightBox,
                                            "${data[index]['p_price']}"
                                                .numCurrency
                                                .text
                                                .color(redColor)
                                                .fontFamily(bold)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .padding(const EdgeInsets.all(8))
                                            .roundedSM
                                            .make()
                                            .onTap(() {
                                          categoryController
                                              .checkIfProductIsFavorite(
                                                  data[index]);
                                          Get.to(() => ItemDetails(
                                                title: data[index]['p_name'],
                                                data: data[index],
                                              ));
                                        }),
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ).onTap(() {}),
                    ),
                  ],
                ),
                20.heightBox,
                //third Swiper
                VxSwiper.builder(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayAnimationDuration: 1.seconds,
                  height: 130,
                  enlargeCenterPage: true,
                  itemCount: sliderList.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      sliderList[index],
                      fit: BoxFit.fill,
                    )
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .margin(const EdgeInsets.symmetric(horizontal: 8))
                        .make();
                  },
                ),

                ///
                /// All Products sectios
                20.heightBox,
                //to show 2 item per grid
                StreamBuilder(
                    stream: FireStoreServices.getAllProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "No Products Found"
                              .text
                              .size(20)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: data[index]['p_images'][0],
                                    width: 200,
                                    height: 200,
                                    placeholder: (context, url) => Center(
                                      child: loadingIndicator(),
                                    ),
                                  ),
                                  const Spacer(),
                                  data[index]['p_name']
                                      .toString()
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(8))
                                  .roundedSM
                                  .make()
                                  .onTap(() {
                                categoryController
                                    .checkIfProductIsFavorite(data[index]);
                                Get.to(() => ItemDetails(
                                      title: data[index]['p_name'],
                                      data: data[index],
                                    ));
                              });
                            });
                      }
                    })
              ],
            ),
          ),
        )
      ])),
    );
  }
}
