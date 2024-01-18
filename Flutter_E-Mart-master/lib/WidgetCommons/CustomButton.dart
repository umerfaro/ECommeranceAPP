import 'package:emart_app/consts/consts.dart';

Widget customButtonWidget({
  onPress,
  String? title,
  textColor,
  color,
  bool loading = false,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: loading ? null : onPress,
    child:loading ? const RepaintBoundary(
        child: CircularProgressIndicator(
          color: whiteColor,
        ))   :  title!.text.color(textColor).fontFamily(bold).make(),
  );
}