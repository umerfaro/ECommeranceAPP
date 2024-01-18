import 'package:emart_app/consts/consts.dart';

Widget customTextFormField(
    {String? title,
    String? hint,
    bool? isPassword,
      BuildContext? context,
       FocusNode? myFocusNode,
        FormFieldSetter? onFiledSubmittedValue,
      FormFieldValidator? onValidateValue,
      TextEditingController? controller,
      bool? autoFocus= false

    }) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
    title!.text.color(redColor).fontFamily(semibold).size(16).make(),
    TextFormField(

      onTapOutside: (event) {
        FocusScope.of(context!).unfocus();
      },
maxLines: 1,

      controller: controller,
      onFieldSubmitted: onFiledSubmittedValue,
      validator: onValidateValue,
      autofocus: autoFocus!,
      obscureText: isPassword!,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        hintText: hint,
        isDense: true,
        fillColor: lightGrey,
        hintStyle: const TextStyle(
          fontFamily: semibold,
          color: textfieldGrey,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
        ),
        focusColor: redColor,

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: textfieldGrey),
        ),
        border: InputBorder.none,
      ),
    ),
    5.heightBox,
  ]);
}
