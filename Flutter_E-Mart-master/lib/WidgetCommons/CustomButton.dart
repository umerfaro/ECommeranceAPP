import 'package:emart_app/consts/consts.dart';

Widget customButtonWidget({
  onPress,
  String? title,
  textColor,
  color,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: () {
      // Invoke the onPress function
      onPress();
    },
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}