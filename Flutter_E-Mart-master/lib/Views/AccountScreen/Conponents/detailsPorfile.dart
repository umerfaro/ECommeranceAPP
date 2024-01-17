
import 'package:emart_app/consts/consts.dart';

Widget detailsProfile({width ,String? count,String? title  }){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      count!.text.size(14).color(darkFontGrey).fontFamily(semibold).make(),
      5.heightBox,
      title!.text.size(12).color(darkFontGrey).fontFamily(regular).make(),

    ],
  ).box.width(width).padding(const EdgeInsets.all(4)).rounded.white.make();
}