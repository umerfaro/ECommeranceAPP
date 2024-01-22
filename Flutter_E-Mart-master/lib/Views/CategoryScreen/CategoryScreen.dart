import 'package:emart_app/Views/CategoryScreen/Categories_Details.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Controller/ProductController/ProductController.dart';
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});



  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(ProductController());
    return bgWidget(
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: "Categories".text.white.fontFamily(bold).make(),

          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: categoryListPic.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 200,
              ),
              itemBuilder: (BuildContext context, int index) {
                return  Hero(
                  tag: 'category_image$index',
                  child: Column(
                      children: [
                        Image.asset(
                          categoryListPic[index],
                          width: 200,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        10.heightBox,
                        nameListCategories[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                      ],
                    ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                      categoryController.getSubCat(nameListCategories[index]);
                      Get.to(() => CategoriesDetails(title: nameListCategories[index],));
                  }),
                );
              },
            ),
          ),

        )
    );
  }
}
