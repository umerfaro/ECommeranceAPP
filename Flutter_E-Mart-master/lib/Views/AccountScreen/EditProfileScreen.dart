
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emart_app/Controller/AccountProfileController.dart';
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/WidgetCommons/CustomButton.dart';
import 'package:emart_app/WidgetCommons/CustomTextFormField.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../WidgetCommons/LoadingIndicator.dart';
class EditProfileScreen extends StatefulWidget {

  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  var profileController = Get.put(ProfileController());

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   profileController.nameController.dispose();
  //   profileController.passwordController.dispose();
  //   profileController.phoneNumberController.dispose();
  //
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {


    return  bgWidget(Scaffold(
      appBar: AppBar(
        title: editProfile.text.size(18).white.fontFamily(semibold).make(),
        centerTitle: true,
        backgroundColor: redColor,
      ),
      body: SingleChildScrollView(
        child: Obx(
              ()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              widget.data['photoUrl'] == "" && profileController.profileImagePath.isEmpty
                  ? Image.asset(
                imgProfile2,
                width: 70,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make()
                  : widget.data['photoUrl'] != " " && profileController.profileImagePath.isEmpty
                  ? CachedNetworkImage(
                imageUrl: widget.data['photoUrl'],
                width: 70,
                fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: loadingIndicator(),
            ),
              ).box.roundedFull.clip(Clip.antiAlias).make()
                  : Image.file(
                File(profileController.profileImagePath.value),
                fit: BoxFit.cover,
                width: 70,
              ).box.roundedFull.clip(Clip.antiAlias).make(),


              //    widget.data['photoUrl'] == " " &&  profileController.profileImagePath.isEmpty
              //   ? Image.asset(imgProfile2,width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
              //  : widget.data['photoUrl'] != " " &&  profileController.profileImagePath.isEmpty?
              //        Image.network(widget.data['photoUrl'],width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
              //
              //    :Image.file(
              //     File(profileController.profileImagePath.value),
              // fit: BoxFit.cover,
              //       width: 70,
              //     ).box.roundedFull.clip(Clip.antiAlias).make(),



              10.heightBox,
              customButtonWidget(
                onPress: () {
                  profileController.pickImage(context);
                },
                title: changeProfile,
                textColor: whiteColor,
                color: redColor,
              ),
              const Divider(),
              20.heightBox,
              customTextFormField(

                controller: profileController.nameController,
                title: name,
                hint: nameHint,
                isPassword: false,
                context: context,
              ),

              10.heightBox,
              customTextFormField(
                controller: profileController.phoneNumberController,
                title: phone,
                hint: phoneHint,
                isPassword: false,
                context: context,
              ),
              10.heightBox,
              customTextFormField(
                controller: profileController.passwordController,
                title: password,
                hint: passwordHint,
                isPassword: true,
                context: context,
              ),
              20.heightBox,
              customButtonWidget(
                onPress: () async {


                  if(profileController.profileImagePath.isEmpty)
                  {
                    await profileController.updateProfileWithOutImage(
                      name: profileController.nameController.text,
                      password: profileController.passwordController.text,
                      phoneNumber: profileController.phoneNumberController.text,
                    );
                    Utils.toastMessage("Data has been updated");

                  }
                  else
                  {
                    await profileController.uploadImage();
                    await profileController.updateProfileWithImage(
                      name: profileController.nameController.text,
                      password: profileController.passwordController.text,
                      url: profileController.url,
                      phoneNumber: profileController.phoneNumberController.text,
                    );
                    profileController.url = "";
                    Utils.toastMessage("Data has been updated");
                  }





                },
                loading: profileController.loading2.value,
                title: update,
                textColor: whiteColor,
                color: redColor,
              ).box.width(context.screenWidth - 50).make() ,

            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,left: 12,right: 12 )).rounded.make(),
        ),
      ),


    ));
  }
}