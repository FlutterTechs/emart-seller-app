
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../const/firebase_const.dart';
class ChatController extends GetxController{
     @override
  void onInit() {
       getId();
    super.onInit();
  }
  var chats = firestore.collection(chatsCollection);

  getId({dynamic data}){
    if(data != null){
      senderId = data["fromId"].toString();
      chatDocId = data.id;
    }
  }
  var senderId;
  var currentId = currentUser!.uid;
  var msgController = TextEditingController();
  String getTime(time){
    var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    var orderdate = DateFormat("hh:mm a").format(date);
    return orderdate;
  }
  dynamic chatDocId;
  var isLoading = false.obs;
  var chatData;
  var lastMsgId;
  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      dynamic lastmsgId;
      await chats.doc(chatDocId).collection(messageCollection).add({
        "created_on":FieldValue.serverTimestamp(),
        "msg":msg,
        "sender_id":currentUser!.uid
      }).then((value) {
        lastmsgId = value.id;
      });
      await  chats.doc(chatDocId).update({
        "lastId":lastmsgId
      });


    }
  }
}