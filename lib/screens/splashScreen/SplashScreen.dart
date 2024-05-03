
import 'package:emartseller/const/files.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/firebase_const.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _splashScreen();

}

class _splashScreen extends State<SplashScreen>{
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
      auth.authStateChanges().listen((user) {
        if(user != null){
          Get.offAll(() => DashboardScreen());
        }else{
          Get.offAll(() => LoginScreen());
        }
      });

    });
  }
  @override
  void initState() {
    super.initState();
   changeScreen();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assists/images/logo.png"),
            "Emart Seller".text.bold.size(30).make(),
            Align(
              alignment: Alignment.bottomCenter,
              child: "version : 1.0.0".text.make(),
            )
          ],
        ),
      ),
    );
  }

}