import "package:emart_app/consts/consts.dart";

Widget orderPlaced(
    {required String title1, required String title2, detail1, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title1.text.color(darkFontGrey).fontFamily(bold).make(),
            10.heightBox,
            "$detail1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 120,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            title2.text.color(darkFontGrey).fontFamily(bold).make(),
            10.heightBox,
            "$detail2".text.color(redColor).fontFamily(semibold).make(),
          ]),
        )
      ],
    ),
  );
}
