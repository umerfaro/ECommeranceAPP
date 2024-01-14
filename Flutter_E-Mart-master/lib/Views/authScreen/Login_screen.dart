import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/appLogo_widget.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'SignUpScreen.dart';
import 'ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        // Handle back button press
        if (didPop) {
            SystemNavigator.pop();

          // Pop was successful
          // Perform any action you want when the back button is pres

        } else {
          // Pop was not successful
          // Maybe show a snackbar or perform another action
        }
      },
      child: bgWidget(
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Login in to $appname"
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgotPassword.text
                            .fontFamily(semibold)
                            .color(fontGrey)
                            .make()
                            .onTap(() {
                          Get.to(() => const ForgotPassword());
                        }),
                      ),
                    ),
                    5.heightBox,
                    Hero(
                      tag: 'signup_button', // Unique tag for SignUpScreen
                      child: customButtonWidget(
                        onPress: () {},
                        title: login,
                        textColor: whiteColor,
                        color: redColor,
                      )
                          .box
                          .width(context.screenWidth - 50)
                          .make()
                          .onTap(() {
                        // Navigate to SignUpScreen with a smooth transition
                        Get.to(() => const SignUpScreen());
                      }),
                    ),
                    5.heightBox,
                    dontHaveAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    Hero(
                      tag: 'signup_text', // Unique tag for SignUpScreen
                      child: customButtonWidget(
                        onPress: () {
                          // Navigate to SignUpScreen with a smooth transition
                          Get.to(() => const SignUpScreen());
                        },
                        title: signUp,
                        textColor: redColor,
                        color: lightGolden,
                      )
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                    ),
                    5.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        3,
                            (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
