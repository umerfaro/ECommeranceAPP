import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/Views/CategoryScreen/ItemDetails.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class CategoriesDetails extends StatefulWidget {
 final String? title;
  const CategoriesDetails({super.key, this.title});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  var categoryController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      appBar: AppBar(
        title: widget.title!.text.white.fontFamily(bold).make(),
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      categoryController.subcat.length,
                      (index) => categoryController.subcat[index].toString()
                          .text
                          .size(12)
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .makeCentered()
                          .box
                          .white
                          .size(120, 60)
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .padding(EdgeInsets.all(4))
                          .outerShadowSm
                          .roundedSM
                          .make()),
                ),
              ),
              20.heightBox,
              ///
              /// itemContainer
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics() ,
                        itemCount: 6,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 250,
                        ), itemBuilder: (context,index){
                      return Hero(
                        tag: 'category_details$index',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              featuredProductList[index],
                              width: 200,
                              height: 150,
                            ),
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
                            .roundedSM.outerShadowSm
                            .make().onTap(() {
                              Get.to(() => ItemDetails(title: featuredProductTitle[index], price: featuredProductPrice[index],));
                        }),
                      );
                    }),
                  ),
              )
            ],
          )),
    ));
  }
}
