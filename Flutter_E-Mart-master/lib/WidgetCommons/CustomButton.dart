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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.all(15),
    ),
    onPressed: loading ? null : onPress,
    child:loading ? const RepaintBoundary(
        child: CircularProgressIndicator(

          valueColor: AlwaysStoppedAnimation(whiteColor),
        ))   :  title!.text.color(textColor).fontFamily(bold).make(),
  );
}