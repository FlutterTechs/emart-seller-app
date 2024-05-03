
import 'package:emartseller/const/color.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/const/firebase_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/chatController.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';

import '../productScreen/editProductScreen.dart';
class Chat extends StatefulWidget{
 dynamic data;
  Chat({super.key, this.data});
  @override
  State<StatefulWidget> createState() => _chatScreen(data: this.data);

}

class _chatScreen extends State<Chat>{
 var chatController = Get.put(ChatController());
 dynamic data;
 var product;
 _chatScreen({this.data});
  @override
  void initState() {
    product = FirebaseSerice.getProductById(data["product_id"].toString());
    chatController.getId(data: data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("product Id :");
    print(data.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        titleSpacing: 0,
        title: ListTile(
          leading: CircleAvatar(backgroundColor: Colors.blue,child: Icon(Icons.person),),
         title: Text(data["sender_name"].toString()),
        ),
      ),
      backgroundColor: Colors.white,
      body:
       Stack(
        children: <Widget>[
          StreamBuilder(
                    stream: FirebaseSerice.GetMessages(data.id.toString(),
                    ),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }else if(snapshot.data!.docs.isEmpty){
                    return Center(child: "No Chat Found".text.make(),);
                  }
                  else{
                    chatController.chatData = snapshot.data!.docs;
                    print("data is :");
                    return ListView(
                      children: [
                         FutureBuilder(future: product,
                             builder: (BuildContext context,AsyncSnapshot snapshot){
                           if(!snapshot.hasData){
                             return  CircularProgressIndicator();
                           } else{
                           var data = snapshot.data;
                           print(data.id);
                             return ListTile(
                               leading: SizedBox(
                                 width: 100,
                                 height: 100,
                                 child: Image.network(data["p_image"][0]),
                               ),
                               title: Text(data["p_name"].toString()),
                               trailing: Text("\u20B9 ${data["p_price"]}"),
                             ).box.shadowSm.white.make().onTap(() {
                               Get.to(()=>EditProductScreen(data: data));
                             });
                           }
                         }),
                        10.heightBox,
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: chatController.chatData.length,
                          itemBuilder: (context,index){
                            return BubbleSpecialThree(
                                color: Colors.grey,
                                isSender: chatController.chatData[index]["sender_id"] == currentUser!.uid ? true : false,
                                text: chatController.chatData[index]["msg"]).box.margin(const EdgeInsets.only(bottom: 20)).make();
                          }),]
                    );
                  }
                }),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller:chatController.msgController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      setState(() {

                      });
                      chatController.sendMsg(chatController.msgController.text,
                      );
                      chatController.msgController.clear();
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],

              ).box.gray200.make(),
            ),
          ),
        ],
      ),
    );
  }
}