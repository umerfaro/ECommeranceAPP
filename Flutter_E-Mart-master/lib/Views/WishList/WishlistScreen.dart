import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';

import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:emart_app/viewModel/Services/Session%20manager.dart';

import '../../WidgetCommons/LoadingIndicator.dart';
class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "WishList".text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getWishList(SessionController().userId),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if(!snapshot.hasData)
              {
                return Center(child: loadingIndicator());
              }
              else if(snapshot.data!.docs.isEmpty)
              {
                return "No Orders in Wishlist Yet!".text.size(20).color(darkFontGrey).fontFamily(semibold).makeCentered();

              }
              else
              {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context , int index){
                            return ListTile(

                              contentPadding: const EdgeInsets.all(
                                  16.0), // Adjust padding as needed
                              tileColor: Colors.white, // Set the background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Set border radius
                                side: BorderSide(
                                    color: Colors.grey[300]!), // Set border color
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Set border radius for the image
                                child: Image.network(
                                  data[index]['p_images'][0].toString(),
                                  width: 60.0,
                                  height: 60.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data[index]['p_name']
                                      .toString()
                                      .text
                                      .size(16)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  8.heightBox, // Add some spacing between title and quantity
                                ],
                              ),
                              subtitle: data[index]['p_price']
                                  .toString()
                                  .numCurrency
                                  .text
                                  .size(14)
                                  .fontFamily(regular)
                                  .color(redColor)
                                  .make(),
                              trailing: IconButton(
                                onPressed: () async
                                {
                               await firestore.collection(productCollections).doc(data[index].id).set({
                                  'p_wishList':FieldValue.arrayRemove([currentUser!.uid])

                                },SetOptions(merge: true));//set option merge as liya taka baki data ko replace nah kara

                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: redColor,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }

            }
        )


    );
  }
}
