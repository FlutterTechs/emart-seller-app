import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _profileScreen();
}

class _profileScreen extends State<ProfileScreen>{
  var authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: boldText(title: "Profile", size: 20),
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
               padding: EdgeInsets.all(20),
               child: SingleChildScrollView(
                 scrollDirection: Axis.vertical,
                 child: Column(

                   children: [
                     30.heightBox,
                     CircleAvatar(backgroundColor: Colors.grey,radius: 70,),
                     20.heightBox,
                     boldText(title: "${data["name"].toString()}",size: 20),
                     10.heightBox,
                     Column(
                       children: List.generate(profileIcons.length, (index) {
                         return ListTile(
                           leading: profileIcons[index],
                           title: Text(profileTitles[index]),
                           onTap: (){
                             Get.to(()=>ProfileScreens[index]);
                           },
                         );
                       }),
                     ).box.roundedLg.p12.width(context.screenWidth - 70).color(lightBlue).make(),
                     20.heightBox,
                     ourButton(
                         title: "LogOut",
                         color: darkBlue,
                         textColor: Colors.black,
                         onpress: (){
                           authController.logOut();
                         }
                     ).box.width(context.screenWidth * 0.3).make()
                   ],
                 ),
               ),
             );
           }
          })
    );
     }
}