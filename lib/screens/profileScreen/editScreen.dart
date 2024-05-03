import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
class ChangePassword extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _changePassword();

}

class _changePassword extends State<ChangePassword>{

  var oldPwd = TextEditingController();
  var newPwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: boldText(title: "Change Password",size: 20),
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: StreamBuilder(stream: FirebaseSerice.getUserData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
           if(!snapshot.hasData){
             return Center(child: CircularProgressIndicator(),);
           }else{
             var data = snapshot.data;
             return Container(
               width: double.infinity,
               height: double.infinity,
               child: Center(
                 child: SingleChildScrollView(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       20.heightBox,
                       customTextFeild(
                         controller: oldPwd,
                         title: "Old password",
                         hint: "Enter old password",

                       ),
                       customTextFeild(
                         controller: newPwd,
                         title: "New Password",
                         hint: "Enter New Password",
                       ),
                       20.heightBox,
                       ourButton(
                           title: "Save",
                           textColor: Colors.black,
                           onpress: (){
                             authController.changeAuthPassword(
                               oldPassword: oldPwd.text,
                               newPassword: newPwd.text,
                               confirmPassword: data["password"].toString()
                             );
                           },
                           color: lightBlue
                       ).box.width(200).make(),
                       20.heightBox
                     ],
                   ).box.roundedSM.color(light).p12.shadow.width(context.screenWidth - 70).make(),
                 ),
               ),
             );
           }
          })
    );
  }
}