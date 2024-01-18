import 'package:emart_app/Controller/auth_Controller.dart';
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/Views/HomeStructure/HomeStructureScreen.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/viewModel/GoogleLogin/GoogleAuth.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';
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
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Get the AuthController
  final AuthController controller = Get.put(AuthController());

  // Focus nodes
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Form key
  final GlobalKey<FormState> _logInFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    controller.passwordController.dispose();
    controller.emailController.dispose();

    super.dispose();

  }

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
                Form(
                  key: _logInFormKey,
                  child: Column(
                    children: [
                      customTextFormField(
                        title: email,
                        hint: emailHint,
                        isPassword: false,
                        context: context,
                        controller: controller.emailController,
                        myFocusNode: emailFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(
                            context,
                            emailFocusNode,
                            passwordFocusNode,
                          );
                        },
                        onValidateValue: (value) {
                          return value.isEmpty ? 'Please enter your email' : null;
                        },
                      ),
                      customTextFormField(
                        title: password,
                        hint: passwordHint,
                        isPassword: true,
                        context: context,
                        controller: controller.passwordController,
                        myFocusNode: passwordFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(
                            context,
                            passwordFocusNode,
                            passwordFocusNode,
                          );
                        },
                        onValidateValue: (value) {
                          return value.isEmpty ? 'Please enter your password' : null;
                        },
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
                        tag: 'Login_button',
                        child: Obx(
                              () => customButtonWidget(
                            loading: controller.loginButtonEnable.value || controller.isGoogleSignInLoading.value,
                            onPress: () async {
                              if (_logInFormKey.currentState!.validate())
                              {
                                controller.isGoogleSignInLoading.value = true;

                                await controller.loginMethod().then((value)
                                {
                                  if (value != null) {
                                    SessionController().userId = value.user!.uid.toString();
                                    Utils.toastMessage(loginSuccess);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.loginButtonEnable.value = false;
                                    Utils.toastMessage(loginFailed);
                                  }
                                }).onError((error, stackTrace) => Utils.toastMessage(error.toString()));

                                controller.isGoogleSignInLoading.value = false;
                              }
                            },
                            title: login,
                            textColor: whiteColor,
                            color: redColor,
                          )
                              .box
                              .width(context.screenWidth - 50)
                              .make(),
                        ),
                      ),
                      5.heightBox,
                      dontHaveAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      Hero(
                        tag: 'SignUP_button',
                        child: customButtonWidget(
                          onPress: () {
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
                            child: GestureDetector(
                              onTap: () {
                                // Handle click based on the index
                                switch (index) {
                                  case 0:
                                  // Handle click for the first icon (index 0)
                                    break;
                                  case 1:
                                  // Handle click for the second icon (index 1)
                                  // For example, call the signInWithGoogle method
                                  //  signInWithGoogle(context); // Make sure you have the signInWithGoogle method defined
                                    controller.isGoogleSignInLoading.value = true;
                                    GoogleAuthServices().signInWithGoogle(context).then((value) {
                                      Utils.toastMessage("Login Successfully");
                                    }).whenComplete(()
                                    {
                                      controller.isGoogleSignInLoading.value = false;
                                    });

                                    break;
                                  case 2:
                                  // Handle click for the third icon (index 2)
                                    break;
                                  default:
                                    break;
                                }
                              },
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
                      )

                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
