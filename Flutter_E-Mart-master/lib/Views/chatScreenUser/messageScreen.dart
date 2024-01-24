import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Views/chatScreenUser/chat_Screen.dart';
import 'package:emart_app/consts/consts.dart';

import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../WidgetCommons/LoadingIndicator.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Messages".text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getAllMessages(currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if(!snapshot.hasData)
              {
                return Center(child: loadingIndicator());
              }
              else if(snapshot.data!.docs.isEmpty)
              {
                return "No Messages Yet!".text.size(20).color(darkFontGrey).fontFamily(semibold).makeCentered();

              }
              else
              {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(

                          child: ListView.builder(

                            itemCount: data.length,
                              itemBuilder: (BuildContext context,int index){
                            return Card(
                              color:whiteColor ,

                              child: ListTile(
                                onTap: (){
                                  Get.to(()=>const ChatScreen(),
                                      arguments: [
                                        data[index]['friend_Name'],
                                        data[index]['toId'],
                                      ]
                                  );
                                },
                                title: data[index]['friend_Name'].toString().text.size(20).color(darkFontGrey).fontFamily(semibold).make(),
                                subtitle: data[index]['last_msg'].toString().text.size(15).color(darkFontGrey).fontFamily(semibold).make(),
                                leading: const CircleAvatar(
                                backgroundColor: redColor,
                                  child: Icon(Icons.person,color: whiteColor,),
                                  // backgroundImage: NetworkImage(data[index]['friend_image']),

                                ),
                              ),
                            );
                          })
                      ),
                    ],
                  ),
                );
              }

            }
        )


    );
  }
}
