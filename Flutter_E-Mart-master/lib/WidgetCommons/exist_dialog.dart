import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';

import 'CustomButton.dart';

Widget exitDialogWidget(BuildContext context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm Exit"
            .text
            .color(darkFontGrey)
            .size(18)
            .fontFamily(bold)
            .make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            customButtonWidget(
              onPress: () {
                Navigator.pop(context);
              },
              title: "No",
              textColor: whiteColor,
              color: redColor,
            ),
            customButtonWidget(
              onPress: () {
                SystemNavigator.pop();
              },
              title: "Yes",
              textColor: whiteColor,
              color: redColor,
            ),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
