import 'package:emart_app/Controller/auth_Controller.dart';
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/Views/authScreen/Login_screen.dart';
import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/WidgetCommons/appLogo_widget.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var controller = Get.put(AuthController());

  // Text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetryController = TextEditingController();

  // Focus nodes
  var nameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var passwordRetryFocusNode = FocusNode();

  final _simpleSignUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetryController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordRetryFocusNode.dispose();
    controller.resetCheckboxState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
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
                Form(
                  key: _simpleSignUpFormKey,
                  child: Column(
                    children: [
                      customTextFormField(
                        title: name,
                        hint: nameHint,
                        isPassword: false,
                        context: context,
                        controller: nameController,
                        myFocusNode: nameFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(context, nameFocusNode, emailFocusNode);
                        },
                        onValidateValue: (value) {
                          return value.isEmpty ? 'Please enter your Username' : null;
                        },
                      ),
                      customTextFormField(
                        title: email,
                        hint: emailHint,
                        isPassword: false,
                        context: context,
                        controller: emailController,
                        myFocusNode: emailFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(context, emailFocusNode, passwordFocusNode);
                        },
                        onValidateValue: (value) {
                          return value.isEmpty ? 'Please enter your Email' : null;
                        },
                      ),
                      customTextFormField(
                        title: password,
                        hint: passwordHint,
                        isPassword: true,
                        context: context,
                        controller: passwordController,
                        myFocusNode: passwordFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(context, passwordFocusNode, passwordRetryFocusNode);
                        },
                        onValidateValue: (value) {
                          return value.isEmpty ? 'Please enter your Password' : null;
                        },
                      ),
                      customTextFormField(
                        title: retryPassword,
                        hint: ret,
                        isPassword: true,
                        context: context,
                        controller: passwordRetryController,
                        myFocusNode: passwordRetryFocusNode,
                        onFiledSubmittedValue: (value) {
                          Utils.fieldFocus(context, passwordRetryFocusNode, passwordRetryFocusNode);
                        },
                        onValidateValue: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
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
                          Obx(
                                () => Checkbox(
                              activeColor: lightGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              
                              side: const BorderSide(color: darkFontGrey),
                              checkColor: redColor,
                              value: controller.isChecked.value,
                              onChanged: (newValue) {
                                controller.isChecked.value = newValue ?? false;
                              },
                            ),
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: agreeTo, style: TextStyle(color: fontGrey, fontFamily: regular)),
                                  TextSpan(text: termsAndConditions, style: TextStyle(color: redColor, fontFamily: regular)),
                                  TextSpan(text: " and ", style: TextStyle(color: fontGrey)),
                                  TextSpan(text: privacyPolicy, style: TextStyle(color: redColor, fontFamily: regular)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      5.heightBox,
                      Obx(
                            () => customButtonWidget(
                          loading: controller.signButtonEnable.value,
                              onPress: () async {
                                if (controller.isChecked.value != false) {
                                  if (_simpleSignUpFormKey.currentState!.validate()) {
          
                                    controller.signUp(
                                        context,
                                        nameController.text.toString(),
                                        emailController.text.toString(),
                                        passwordController.text.toString()
          
                                    );
          
                                  }
                                }
                              },
                              title: signUp,
                          textColor: whiteColor,
                          color: controller.isChecked.value == true ? redColor : lightGrey,
                        )
                            .box
                            .width(context.screenWidth - 50)
                            .make(),
                      ),
                      10.heightBox,
                      Hero(
                        tag: 'loginBack_text',
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(text: alreadyHaveAccount, style: TextStyle(color: fontGrey, fontFamily: bold)),
                              TextSpan(text: login, style: TextStyle(color: redColor, fontFamily: regular)),
                            ],
                          ),
                        ).onTap(() {
          
                          Get.back();
                        }),
                      ),
                    ],
                  ),
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16))
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
