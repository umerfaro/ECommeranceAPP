import 'package:emart_app/Controller/cartController.dart';
import 'package:emart_app/Views/CartScreen/Payment_screen.dart';
import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../Utils/Utils.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var shipController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: shipping_Information.text
            .size(20)
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        width: context.screenWidth - 40,
        child: customButtonWidget(
          onPress: () {
            if (shipController.logInFormKey.currentState!.validate()) {

              Get.to(() => const PaymentMethods());


            }
          },
          title: "Continue",
          textColor: whiteColor,
          color: redColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: shipController.logInFormKey,
          child: Column(
            children: [
              customTextFormField(
                myFocusNode: shipController.addressFocus,
                onFiledSubmittedValue: (value) {
                  Utils.fieldFocus(
                    context,
                    shipController.addressFocus,
                    shipController.cityFocus,
                  );
                },
                controller: shipController.addressController,
                title: address,
                hint: address_hint,
                isPassword: false,
                context: context,
                autoFocus: true,
                onValidateValue: (value) {
                  return value.isEmpty ? 'Enter your address' : null;
                },
              ),
              customTextFormField(
                myFocusNode: shipController.cityFocus,
                onFiledSubmittedValue: (value) {
                  Utils.fieldFocus(
                    context,
                    shipController.cityFocus,
                    shipController.stateFocus,
                  );
                },
                controller: shipController.cityController,
                title: city,
                hint: city_hint,
                isPassword: false,
                context: context,
                autoFocus: true,
                onValidateValue: (value) {
                  return value.isEmpty ? 'Enter your city' : null;
                },
              ),
              customTextFormField(
                onValidateValue: (value) {
                  return value.isEmpty ? 'Enter your state' : null;
                },
                myFocusNode: shipController.stateFocus,
                onFiledSubmittedValue: (value) {
                  Utils.fieldFocus(
                    context,
                    shipController.stateFocus,
                    shipController.zipCodeFocus,
                  );
                },
                controller: shipController.stateController,
                title: state,
                hint: state_hint,
                isPassword: false,
                context: context,
                autoFocus: true,
              ),
              customTextFormField(
                myFocusNode: shipController.zipCodeFocus,
                onFiledSubmittedValue: (value) {
                  Utils.fieldFocus(
                    context,
                    shipController.zipCodeFocus,
                    shipController.phoneFocus,
                  );
                },
                controller: shipController.zipCodeController,
                title: zipCode,
                hint: zipCode_hint,
                isPassword: false,
                context: context,
                autoFocus: true,
                onValidateValue: (value) {
                  return value.isEmpty ? 'Enter your zip code' : null;
                },
              ),
              customTextFormField(
                myFocusNode: shipController.phoneFocus,
                onFiledSubmittedValue: (value) {
                  Utils.fieldFocus(
                    context,
                    shipController.phoneFocus,
                    shipController.phoneFocus,
                  );
                },
                controller: shipController.phoneController,
                title: phone,
                hint: phoneHint,
                isPassword: false,
                context: context,
                autoFocus: true,
                onValidateValue: (value) {
                  return value.isEmpty ? 'Enter your phone number' : null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
