import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
Widget StatusCart({String? title,String? address,required bool status,required Timestamp time}){
  var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
  var orderdate = DateFormat("dd-MM-yyyy, hh:mm a").format(date);
  return Column(
    children: [
      10.heightBox,
      Container(
        width: 300,
        child: boldText(title: "$title",size: 15),
      ),
      ListTile(
        leading: Icon(Icons.location_on),
        title: Text("street Address",style: TextStyle(fontSize: 8),),
        subtitle: Text("$address",style: TextStyle(fontSize: 12),),
      ),
      Divider(color: Colors.grey),
      ListTile(
        leading: Icon(Icons.calendar_month_outlined),
        title: Text(orderdate),
        trailing: status ? "Delivered".text.green700.make()  :"Cancel".text.red400.make(),
      )
    ],
  ).box.p8.make();
}