

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';

import "package:intl/intl.dart" as intl;// for time

Widget senderBubble(DocumentSnapshot data){

  var t= data['created_on']==null?DateTime.now():data['created_on'].toDate();
var time = intl.DateFormat("h:mma").format(t);

  return    Directionality(
    textDirection: data['uid']==currentUser!.uid?TextDirection.rtl:TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),

      decoration:  BoxDecoration(
        color: data['uid']==currentUser!.uid ?redColor : darkFontGrey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomRight: Radius.circular(data['uid'] == currentUser!.uid ? 0 : 20),
          bottomLeft: Radius.circular(data['uid'] == currentUser!.uid ? 20 : 0),

        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          "${data['msg']}".text.size(16).color(whiteColor).make(),
          10.heightBox,
          time.text.size(12).color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}