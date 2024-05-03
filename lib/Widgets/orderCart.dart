
import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';

import 'ourButton.dart';

Widget orderCart({
  String? Title,
  String? Address,
  cencel,
  accept,
}){
  String tm = "01 Jun 2022 | 00.14 AM";
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      10.heightBox,
      boldText(title: Title,size: 20).box.margin(EdgeInsets.only(left: 10)).make(),
      Divider(color: Colors.grey,),
      ListTile(
        leading: Icon(Icons.watch_later_outlined),
        title: Text("date & Time",style: TextStyle(fontSize: 10),),
        subtitle: Text(tm,style: TextStyle(fontSize: 14),),
      ),
      ListTile(
        leading: Icon(Icons.location_on),
        title: Text("street Address",style: TextStyle(fontSize: 10),),
        subtitle: Text(Address!,style: TextStyle(fontSize: 14),softWrap: true,),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ourButton(
            title: "Decline",
            textColor: Colors.red.shade700,
            color: Colors.red.shade400,
            onpress: cencel
          ).box.width(150).make(),
          ourButton(
            title: "Accept",
            color: Colors.greenAccent,
            textColor: Colors.green,
            onpress: accept
          ).box.width(150).make(),

        ],
      ),
      10.heightBox
    ],
  );
}