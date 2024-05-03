
import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/notificationController.dart';
import 'package:emartseller/controller/orderController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
Widget UpcomingCart({String? name,String? img,String? qty,String? price,required BuildContext context,String? docId,String? PaymentType,required Timestamp time,String? token}){
  var controller = Get.put(OrderController());
  var notiCon = Get.put(NotificationController());
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
               TextButton(
                   style: TextButton.styleFrom(
                     foregroundColor: Colors.green,
                 shape: RoundedRectangleBorder(
                   side: BorderSide(width: 1,color: Colors.grey),
                   borderRadius: BorderRadius.circular(12)
                 )
               ),
                   onPressed: (){
                     controller.orderConfirmed(docId);
                      notiCon.sendMsg(
                        title: "Your Order Accepted",
                        body: name.toString(),
                        token: token
                      );
                   }, child: Text("Approved",style: TextStyle(
                 color: Colors.green
               ),)),
               5.widthBox,
               TextButton(
                   style: TextButton.styleFrom(
                       foregroundColor: Colors.red,
                       shape: RoundedRectangleBorder(
                           side: BorderSide(width: 1,color: Colors.grey),
                           borderRadius: BorderRadius.circular(12)
                       )
                   ),
                   onPressed: (){
                     controller.orderRejected(docId);
                   }, child: Text("Reject",style: TextStyle(
                 color: Colors.red
               ),)),
               5.widthBox,
               "$PaymentType".text.wrapWords(true).maxLines(2).white.make().box.color(Colors.cyanAccent).p8.make()
             ],
           ),
           10.heightBox,
           Container(
           child:Text(name!,
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