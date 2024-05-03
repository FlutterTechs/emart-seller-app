import 'dart:ffi';

import 'package:get/get_core/src/get_main.dart';
import 'package:emartseller/const/files.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../const/firebase_const.dart';
import '../screens/login/loginScreen.dart';
class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  var ageCon = TextEditingController();
  var numberCon = TextEditingController();
  var email = TextEditingController();
  var pwd = TextEditingController();
  var oldPassword = TextEditingController();
  var newPasswordCon = TextEditingController();
  var updatePasswordCon = TextEditingController();


  static const productCollection = "product";
  static const orderCollection = "Orders";


  checkUser() async {
    var seller = await firestore.collection(vendorCollection)
        .doc(currentUser!.uid)
        .get();
    if (seller == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> login() async {
    if (emailCon.text != "" && passwordCon.text != "") {
      try {
        await auth.signInWithEmailAndPassword(email:
        emailCon.text, password: passwordCon.text
        ).then((value) {
          Fluttertoast.showToast(msg: "login successfully");
          if (checkUser()) {
            Get.offAll(() => DashboardScreen());
          } else {
            auth.signOut();
            Fluttertoast.showToast(msg: "Wrong email or password");
          }
        }).onError((error, stackTrace) {
          Fluttertoast.showToast(msg: "incorrect username or password");
        });
      } catch (e) {
        if (kDebugMode) {
          print("login error :$e");
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all items");
    }
  }

  Future<void> logOut() async {
    try{
      await auth.signOut();
      Get.offAll(()=>const LoginScreen());
    }catch(e){
      print("Error:");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> changeAuthPassword({oldPassword,confirmPassword,newPassword}) async{
    if(oldPassword == confirmPassword){
      User? user = FirebaseAuth.instance.currentUser;
      try{
        user!.updatePassword(newPassword);
        await  firestore.collection(vendorCollection).doc(currentUser!.uid).update({
          "password":newPassword
        });
        auth.signOut();
        print("password Updated sucessfully");
        Get.offAll(()=>LoginScreen());

      }catch(e){
        print("Password Change Error : $e");
      }

    }else{
      Fluttertoast.showToast(msg: "Password Doesn't match");
    }

  }


  Future<void> updateUserData({
    String? name,
    String? age,
    String? email,
    String? password,
    String? number,
  }) async {
    try {
      var shop = firestore.collection(vendorCollection).doc(currentUser!.uid);
      await shop.update({
        "name": name,
        "age": age,
        "email": email,
        "password": password,
        "number": number
      });
    } catch (e) {
      if (kDebugMode) {
        print("update profile error : $e");
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUserName();
    super.onInit();
  }

  var sellername;

  getUserName() async {
   sellername = await firestore.collection(shop)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return [value.docs.single["name"],value.docs.single["password"]];
      }
    });
  }




}