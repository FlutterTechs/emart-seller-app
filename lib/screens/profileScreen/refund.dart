import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../const/color.dart';
import '../../widgets/boldText.dart';
class Refund extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _refund();

}

class _refund extends State<Refund>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(size: 20,title: "Refund"),
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(12),
          child: ListView.separated(
            itemCount: 20,
            itemBuilder: (context,index){
              return ListTile(
                leading: CircleAvatar(backgroundColor: Colors.grey,),
                title: "Persone Name".text.make(),
                subtitle: "Yesterday 20:12".text.make(),
                trailing: boldText(title: "-\$800",size: 20),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey,);
          },)
      ));

  }
}