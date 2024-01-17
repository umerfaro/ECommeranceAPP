import 'package:emart_app/Views/AccountScreen/Conponents/detailsPorfile.dart';
import 'package:emart_app/WidgetCommons/bg_widgt.dart';
import 'package:emart_app/consts/List.dart';
import 'package:emart_app/consts/consts.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return  bgWidget(Scaffold(
      body:SafeArea(
        child: Column(

          children: [
            20.heightBox,
            //edit profile button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.edit,color: whiteColor,size: 20,

                ),
              ).onTap(() {
                //edit profile button on tap
              }),
            ),
        //user details section
          10.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                Image.asset(imgProfile2,width: 70,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
              10.widthBox,
                  Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Dummy User".text.size(18).white.fontFamily(semibold).make(),
                  5.heightBox,
                  "customer@gmail.com ".text.size(14).white.fontFamily(regular).make(),
                ],
              )),
                        ],
                      ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                detailsProfile(width: context.screenWidth/3.4,count: "00",title: incart),
                detailsProfile(width: context.screenWidth/3.4,count: "00",title: wishlist),
                detailsProfile(width: context.screenWidth/3.4,count: "00",title: myOrders),

              ],
            ),

            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context,index){
                return Divider(
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
              onPressed: () {
                // Your onPressed logic here
              },
              child: logout.text.fontFamily(bold).color(lightGrey).make(),
            ),


          ],

                )

    )
    ));
  }
}
