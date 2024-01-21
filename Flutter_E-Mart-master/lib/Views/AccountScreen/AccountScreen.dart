import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Controller/AccountProfileController.dart';
import 'package:emart_app/Controller/auth_Controller.dart';
import 'package:emart_app/Utils/Utils.dart';
import 'package:emart_app/Views/AccountScreen/Conponents/detailsPorfile.dart';
import 'package:emart_app/Views/AccountScreen/EditProfileScreen.dart';

import 'package:emart_app/Views/authScreen/Login_screen.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';
import 'package:get/get.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {

    var profileController = Get.put(ProfileController());

    return  bgWidget(Scaffold(
      appBar: AppBar(
        title: account.text.size(18).white.fontFamily(semibold).make(),
        centerTitle: true,
        backgroundColor: redColor,
      ),
      body:StreamBuilder(
        stream: FireStoreServices.getUser(SessionController().userId.toString()),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
          {

            if(!snapshot.hasData)
              {
                return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);

              }else
                {

                  var data = snapshot.data!.docs[0];

                  return Column(


                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: data['photoUrl'].toString() == ""
                              ? Image.asset(
                            imgProfile2,
                            width: 70,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                              : CachedNetworkImage(
                            imageUrl: data['photoUrl'].toString(),
                            width: 70,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data['name'] == null
                                  ? "Dummy User".text.size(18).white.fontFamily(semibold).make()
                                  : data['name'].toString().text.size(18).white.fontFamily(semibold).make(),
                              5.heightBox,
                              data['email'] == null
                                  ? "customer@gmail.com ".text.size(14).white.fontFamily(regular).make()
                                  : data['email'].toString().text.size(14).white.fontFamily(regular).make(),
                            ],
                          ),
                          trailing: const Icon(Icons.edit,color: whiteColor,size: 20,
                          ).onTap(() {



                            data['name']!=Null? profileController.nameController.text = data['name']: profileController.nameController.text = "No Name" ;
                            data['PhoneNumber']!=Null?
                            profileController.phoneNumberController.text = data['PhoneNumber']: profileController.phoneNumberController.text = "No Phone" ;
                            data['password']!=Null?
                            profileController.passwordController.text = data['password']: profileController.passwordController.text = "No Password";
                            profileController.oldPassword=data['password'].toString();

                            Get.to(()=>  EditProfileScreen(data: data, ));




                            //edit profile button on tap
                          }),
                        ),

                      ),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          detailsProfile(width: context.screenWidth/3.4,

                              count:data['cart_count'].toString(),
                              title: incart),
                          detailsProfile(width: context.screenWidth/3.4,
                              count: data['wishList'].toString()
                              ,title: wishlist),
                          detailsProfile(width: context.screenWidth/3.4,
                              count: data['orderCount'].toString(),
                              title: myOrders),

                        ],
                      ),
                      10.heightBox,

                      ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileList.length,
                          itemBuilder: (contex,index){
                            return ListTile(
                              leading: Image.asset(
                                profileListIcon[index],
                                width: 22,

                              ),
                              title: profileList[index].text.size(14).fontFamily(semibold).color(darkFontGrey).make(),
                            );
                          }).box.white.rounded.margin(EdgeInsets.all(12)).padding(EdgeInsets.symmetric(horizontal:16 )).shadowSm.make().box.color(redColor).make(),
                      20.heightBox,

                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: lightGrey
                          ),
                          backgroundColor: redColor, // Set the background color here
                        ),
                        onPressed: () async {
                          // Your onPressed logic here
                          await Get.put(AuthController()).signOutMethod();

                          Utils.toastMessage(logOut);

                          SessionController().logout();

                          Get.offAll(()=> const LoginScreen());

                          },
                        child: logout.text.fontFamily(bold).color(lightGrey).make(),
                      ),


                    ],

                  );

                }


          }
    )
    )
    );
  }
}
