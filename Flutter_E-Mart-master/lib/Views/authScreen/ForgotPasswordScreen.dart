import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/WidgetCommons/appLogo_widget.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/consts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Forgot your password? Don't worry, even superheroes lose their capes sometimes!"
                  .text
                  .fontFamily(regular)
                  .white
                  .center
                  .size(16).heightRelaxed // Adjust the size as needed for aesthetics
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


                  5.heightBox,
                  customButtonWidget(
                    onPress: () {},
                    title: sendOtp,
                    textColor: whiteColor,
                    color: redColor,
                  )
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  5.heightBox,
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
    );
  }
}
