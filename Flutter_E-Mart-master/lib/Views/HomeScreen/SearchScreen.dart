import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/WidgetCommons/LoadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/ProductController/ProductController.dart';
import '../../viewModel/Services/FireStoreServices.dart';
import '../CategoryScreen/ItemDetails.dart';

class SearchScreen extends StatelessWidget {
 final String? search;

  const SearchScreen({super.key, this.search});

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(ProductController());
    return  SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar:AppBar(
          title: search!.text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: FutureBuilder(
          future: FireStoreServices.getSearchProducts(search),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot )
          {
            if(!snapshot.hasData)
              {
                return  Center(child: loadingIndicator(),);
              }
            else if(snapshot.data!.docs.isEmpty)
              {
                return "No Products Found!".text.size(20).color(darkFontGrey).fontFamily(semibold).makeCentered();
              }
            else
              {
                var data = snapshot.data!.docs;
                var filter = data.where((element) => element['p_name'].toString().toLowerCase().contains(search!.toLowerCase())).toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    //here use chilldren instead of buildcontext
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2
                      ,mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300
                  ),
                    //here use chilldren instead of buildcontext
                      children: filter.mapIndexed((currentValue, index)=>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filter[index]['p_images'][0],
                                width: 200,
                                height: 200,
                              ),
                              const Spacer(),
                              filter[index]['p_name'].toString()
                                  .text
                                  .white
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filter[index]['p_price']}".numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ).box.white
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(8))
                              .roundedSM.shadowMd
                              .make().onTap(()
                          {
                            categoryController.checkIfProductIsFavorite(filter[index]);
                            Get.to(()=> ItemDetails(
                              title:  filter[index]['p_name'],
                              data: filter[index],
                            ));
                          })

                      ).toList()),
                );

              }


          },

        ),
      ),
    );
  }
}
