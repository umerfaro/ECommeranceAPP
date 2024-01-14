import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/WidgetCommons/appLogo_widget.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Join the $appname"
                  .text
                  .fontFamily(bold)
                  .white
                  .bold
                  .size(22)
                  .make(),
              15.heightBox,
              Column(
                children: [
                  customTextFormField(
                    title: name,
                    hint: nameHint,
                    isPassword: false,
                    context: context,
                  ),

                  customTextFormField(
                    title: email,
                    hint: emailHint,
                    isPassword: false,
                    context: context,
                  ),
                  customTextFormField(
                    title: password,
                    hint: passwordHint,
                    isPassword: true,
                    context: context,
                  ),
                  customTextFormField(
                    title: retryPassword,
                    hint: ret,
                    isPassword: true,
                    context: context,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: loginWithPhone.text
                          .fontFamily(semibold)
                          .color(fontGrey)
                          .make(),
                    ),
                  ),

                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          checkColor: redColor,
                          value: false, onChanged: (newValue){
                            isChecked = newValue;

                      }),
                      10.widthBox,
                      Expanded(
                        child: RichText(text:  const TextSpan(
                            children: [
                              TextSpan(text: agreeTo,style: TextStyle(color: fontGrey,fontFamily: regular)),
                              TextSpan(text: termsAndConditions,style: TextStyle(color: redColor,fontFamily: regular)),
                              TextSpan(text: " and ",style: TextStyle(color: fontGrey)),
                              TextSpan(text: privacyPolicy,style: TextStyle(color: redColor,fontFamily: regular)),
                            ]
                        )
                        ),
                      )
                    ],
                  ),
                  5.heightBox,
                  customButtonWidget(
                      onPress: () {},
                      title: signUp,
                      textColor: whiteColor,
                      color:isChecked==true? redColor: lightGrey)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  Hero(
                    tag: 'loginBack_text',
                    child: RichText(text:  const TextSpan(
                        children: [
                          TextSpan(text: alreadyHaveAccount,style: TextStyle(color: fontGrey,fontFamily: bold)),
                          TextSpan(text: login,style: TextStyle(color: redColor,fontFamily: regular)),

                        ]
                    )
                    ).onTap(() {
                      Get.back();
                    }),
                  ),


                ],

              )
                  .box
                  .white
                  .rounded
                  .padding(EdgeInsets.all(16))
                  .width(context.screenWidth - 70).shadowSm
                  .make(),
            ],
          )),
    ));
  }
}
