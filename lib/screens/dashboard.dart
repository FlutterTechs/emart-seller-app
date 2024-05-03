import 'dart:convert';

import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/notificationController.dart';
import 'package:flutter/material.dart';

import '../Services/notificationService.dart';
import 'package:http/http.dart' as http;


class DashboardScreen extends StatefulWidget{
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _dashboardScreen();

}

// ignore: camel_case_types
class _dashboardScreen extends State<DashboardScreen>{
  NotificationService notificationService = NotificationService();
  var notiCon = Get.put(NotificationController());

@override
  void initState() {
  notificationService.requestPermission();
  var token =  notificationService.getDeviceToken();
  notificationService.firebaseInit(context);
  notificationService.setInteractMessage(context);
  if (kDebugMode) {
    print(token);
  }
    super.initState();
  }
  var data = {
    'to':'fDoKbOPDQg6GGNh-jmrQZ2:APA91bG2KNyei54hSkJ2lCx2eT3-c6Ax8A41m0PYW-cAa0JnYFrd5fj7FXOPolunWrmsRqq-_eQzq5jS81ELi_Cz4umjMybu4I-th_f4HJGDmxVbVXSxmpIWdEYbbb2QXkG_7AkzKlYF',
    'priority':'high',
    'notification':{
      'title':'Otp',
      'body':'your otp is 22564'
    },
    'data':{
      'type':'msg',
      'id':'554555'
    }
  };
  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    return Scaffold(
      body:Column(
        children: [
          Obx(() => Expanded(child: Screen.elementAt(homeController.index.value)))
        ],
      ),
      bottomNavigationBar: Obx(
          ()=> BottomNavigationBar(
          backgroundColor: lightBlue,
            selectedItemColor: whiteColor,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedLabelStyle: const TextStyle(fontFamily: bold),
            currentIndex: homeController.index.value,
            onTap: (val){
            homeController.index.value = val;
            },
            type: BottomNavigationBarType.fixed,
            items: navbarItems),
      ),
    /*    floatingActionButton: FloatingActionButton(onPressed:() => sendOtp(),
      backgroundColor: Colors.redAccent,
      child: Icon(Icons.send),
      elevation: 50,
      hoverColor: Colors.green,),*/
    );
  }
  /*sendOtp() async{
    var res =  await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers:{
          "Content-Type": "application/json",
          'Authorization':'key=AAAA8Vu0gSU:APA91bHp8DuaGZulHVKAqNiot16yiXEKuibuxsa03bbg4r-ZqeLurjF1GdFP06i-48Ug9PPb0GBWd42MZ3yY1hnh1X1MqjoucNXPBDAFaAzhXCEAyOfS7OnY4vPL7jqy7yNIFK4UUtht'
        }

    );
    print(notiCon.getCustomerToken("yBZnbCFVwefNnTn9Xu4aF7VODf73"));
    if(res.statusCode == 200){
      print(res.body);
      print("send data");
    }else{
      print("have some error");
    }
  }*/

}