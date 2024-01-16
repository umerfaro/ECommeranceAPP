import 'package:emart_app/Views/HomeScreen/Components/Featursbuttons.dart';
import 'package:emart_app/WidgetCommons/HomeButtons.dart';
import 'package:emart_app/consts/consts.dart';

import '../../consts/List.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            decoration: const InputDecoration(
              hintText: search,
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontFamily: semibold,
                color: textfieldGrey,
              ),
              suffixIcon: Icon(Icons.search),
              filled: true,
              fillColor: whiteColor,
            ),
          ),
        ),
        20.heightBox,
       Expanded(
         child: SingleChildScrollView(
           physics: const BouncingScrollPhysics() ,
           child: Column(
             children: [
               //swapperBrandlist
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
                 height: 130,
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
               Align
                 (
                   alignment: Alignment.centerLeft,
                   child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children:List.generate(3, (index) => Column(
                     children: [
                       featuredButton(images: featuredListUpper[index],title: featuredListUpperTitle[index]),
                        10.heightBox,
                       featuredButton(images: featuredListLower[index],title: featuredListLowerTitle[index]),

                     ],
                   )).toList() ,
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
                       fit: BoxFit.cover, // or BoxFit.fill, depending on your requirement
                     ),
                   ),

                   // Content on top of the background image
                   Container(
                     padding: EdgeInsets.all(12),
                     width: double.infinity,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         featuredProducts.text.white.fontFamily(bold).size(18).make(),
                         10.heightBox,
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
                               ).box.white
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
                 ],
               )
               ,
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
                       .margin(EdgeInsets.symmetric(horizontal: 8))
                       .make();
                 },
               ),

               ///
               /// All Products sectios
               20.heightBox,
               //to show 2 item per grid
               GridView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 itemCount: 6,
                   shrinkWrap: true,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,mainAxisSpacing: 8,
                     crossAxisSpacing: 8,
                     mainAxisExtent: 300
                   ), itemBuilder: (context,index){
                 return Column(
 crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Image.asset(
                       featuredProductList[index],
                       width: 200,
                       height: 200,
                     ),
                    const Spacer(),
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
                 ).box.white
                     .margin(const EdgeInsets.symmetric(horizontal: 4))
                     .padding(const EdgeInsets.all(8))
                     .roundedSM
                     .make();
               })
         
             ],
           ),
         ),
       )

      ])),
    );
  }
}
