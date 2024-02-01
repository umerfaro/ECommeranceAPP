import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/ProductController/ProductController.dart';
import 'package:emart_app/Views/CategoryScreen/ItemDetails.dart';
import 'package:emart_app/WidgetCommons/LoadingIndicator.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:get/get.dart';

class CategoriesDetails extends StatefulWidget {
  final String? title;
  const CategoriesDetails({super.key, this.title});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (categoryController.subCat.contains(title)) {
      productMethod = FireStoreServices.getSubCategoires(title);
    } else {
      productMethod = FireStoreServices.getProducts(title);
    }
  }

  var categoryController = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
        appBar: AppBar(
          title: widget.title!.text.white.fontFamily(bold).make(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    categoryController.subCat.length,
                    (index) => categoryController.subCat[index]
                            .toString()
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .size(120, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .padding(const EdgeInsets.all(4))
                            .outerShadowSm
                            .roundedSM
                            .make()
                            .onTap(() {
                          switchCategory(
                              categoryController.subCat[index].toString());
                          setState(() {});
                        })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(child: Center(child: loadingIndicator()));
                } else if (snapshot
                    .data!.docs.isEmpty) // if data received is empty
                {
                  return Expanded(
                    child: "No Products Found"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;

                  return

                      ///
                      /// itemContainer
                      Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 250,
                          ),
                          itemBuilder: (context, index) {
                            return Hero(
                              tag: 'category_details$index',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: data[index]['p_images'][0],
                                    width: 200,
                                    height: 150,
                                    placeholder: (context, url) => Center(
                                      child: loadingIndicator(),
                                    ),
                                  ),
                                  "${data[index]['p_name']}"
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
                                  .outerShadowSm
                                  .make()
                                  .onTap(() {
                                categoryController
                                    .checkIfProductIsFavorite(data[index]);

                                Get.to(() => ItemDetails(
                                      title: "${data[index]['p_name']}",
                                      data: data[index],
                                    ));
                              }),
                            );
                          }),
                    ),
                  );
                }
              },
            ),
          ],
        )));
  }
}
