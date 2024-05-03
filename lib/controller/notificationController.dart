import 'dart:convert';

import 'package:emartseller/const/files.dart';
import 'package:emartseller/const/firebase_const.dart';
import 'package:http/http.dart' as http;
class NotificationController extends GetxController{

  sendMsg({String? token,String? title,String? body}) async{
    var data = {
      'to':token.toString(),
      'priority':'high',
      'notification':{
        'title':title.toString(),
        'body':body.toString()
      },
      'data':{
        'type':'msg',
        'id':'554555'
      }
    };

    var res =  await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers:{
          "Content-Type": "application/json",
          'Authorization':'key=AAAA8Vu0gSU:APA91bHp8DuaGZulHVKAqNiot16yiXEKuibuxsa03bbg4r-ZqeLurjF1GdFP06i-48Ug9PPb0GBWd42MZ3yY1hnh1X1MqjoucNXPBDAFaAzhXCEAyOfS7OnY4vPL7jqy7yNIFK4UUtht'
        }

    );
    if(res.statusCode == 200){
      print(res.body);
      print("send data");
    }else{
      print("have some error");
    }
  }
   getCustomerToken(docId) async{
   var a =  firestore.collection(usersCollection).where("is",isEqualTo: docId).get();
  }
  }
