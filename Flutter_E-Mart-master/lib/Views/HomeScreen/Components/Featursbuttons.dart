import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../CategoryScreen/Categories_Details.dart';

Widget featuredButton({String? images, String? title,var categoryController}) {
  return Row(
    children: [
      Image.asset(
        images ?? "",
        width: 40,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      if (title != null)
        title.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .padding(const EdgeInsets.all(4))
      .width(200)
      .outerShadowSm
      .roundedSM
      .make().onTap(() {
    categoryController.getSubCat(title);
    Get.to(() => CategoriesDetails(title: title,));
  });
}
