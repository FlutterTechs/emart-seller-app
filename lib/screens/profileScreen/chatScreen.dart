import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/chatController.dart';
import 'package:flutter/material.dart';

import 'chats.dart';
class ChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _chatScreen();

}

class _chatScreen extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        title: boldText(size: 20,title: "Customers"),
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: StreamBuilder(stream: FirebaseSerice.GetAllChats(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No Chats Available".text.make(),);
          }else if(snapshot == null){
            return Center(child: CircularProgressIndicator(),);
          }else{
            var data = snapshot.data!.docs;
            return ListView.separated(
                itemCount: data.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      Get.to(()=> Chat(data: data[index],));
                    },
                    leading: CircleAvatar(backgroundColor: Colors.grey,child: Icon(Icons.person),),
                    title: data[index]["sender_name"].toString().text.bold.make(),
                    subtitle: StreamBuilder(
                        stream: FirebaseSerice.getLastMsg(docIds:data[index].id ,
                            lastMsgId: data[index]["lastId"].toString()),
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return SizedBox();
                          }else{
                            var msg = snapshot.data;
                            return Text(msg["msg"].toString());
                          }
                        }),
                    trailing: Text(chatController.getTime(data[index]["lastMsgTime"]))
                  );

                }, separatorBuilder: (BuildContext context, int index) {
                  return Divider();
            },);
          }
          })
    );
  }
}