import 'package:emartseller/const/files.dart';
import 'package:emartseller/const/firebase_const.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _loginScreen();

}

class _loginScreen extends State<LoginScreen>{
  var authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            width: context.screenWidth-60,
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextFeild(
                    controller: authController.emailCon,
                    title: "email",
                    hint: "Enter email",
                  ),
                  20.heightBox,
                  customTextFeild(
                    controller: authController.passwordCon,
                    title: "Password",
                    hint: "Enter Password",
                  ),
                  20.heightBox,
                  ourButton(
                      title: "Login",
                      textColor: Colors.black,
                      color: darkBlue,
                      onpress: (){
                       authController.login();
                      }
                  ).box.width(context.screenWidth-70).make()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}