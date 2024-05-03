
import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
Widget dispactCart({required bool status,String? img,String? paymentMethod,String? docId,String? name,String? qty,String? price,required BuildContext context,var time}){
  var date = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
  var orderdate = DateFormat("dd-MM-yyyy, hh:mm a").format(date);
  return  Row(
    children: [
      Column(
        children: [
          Container(
            height: context.screenHeight * 0.1,
            width: context.screenWidth * 0.15,
            child: Image.network(img!),
          ),
          5.heightBox,
          "\u20B9 $price".text.make(),
          5.heightBox,
          "Qty: $qty".text.make()
        ],
      ),
      10.widthBox,
      Container(
        width: context.screenWidth * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                status?"Dispatched".text.white.make().box.color(Colors.green).p8.make()
               :"Ready to dispatch".text.white.make().box.color(Colors.yellow).p8.make() ,
                5.widthBox,
                "$paymentMethod".text.white.make().box.color(Colors.cyanAccent).p8.make()
              ],
            ),
            10.heightBox,
            Container(
             child: Text(name!,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600
                ),),
            )
            ,
            10.heightBox,
            "order Id : $docId".text.make(),
            10.heightBox,
            Text(orderdate),
          ],
        ),
      )
    ],
  ).box.roundedSM.shadow.p12.white.width(context.screenWidth - 10).make();
}
