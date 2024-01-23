import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/WidgetCommons/LoadingIndicator.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/viewModel/Services/FireStoreServices.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/ChaTController.dart';
import 'Compoents/SenderBubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chatController = Get.put(ChaTController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "${chatController.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => chatController.isLoading.value
                    ? Center(
                        child: loadingIndicator(),
                      )
                    : Expanded(
                        child: StreamBuilder(
                          stream: FireStoreServices.getChatMessages(
                              chatController.charDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a message to continue ..."
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            } else {
                              return ListView(
                                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                  return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                      child: senderBubble(data));
                                }).toList(),
                              );
                            }
                          },
                        ),
                      ),
              ),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: chatController.msgController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: const TextStyle(color: darkFontGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    ),
                  )),
                  IconButton(
                      onPressed: () {
                        chatController.sendMsg(chatController.msgController.text);
                        chatController.msgController.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: redColor,
                      )),
                ],
              )
                  .box
                  .height(80)
                  .padding(EdgeInsets.all(12))
                  .margin(EdgeInsets.only(bottom: 8))
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
