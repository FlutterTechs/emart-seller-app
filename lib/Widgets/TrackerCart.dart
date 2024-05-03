import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';

Widget TrackerCart({required BuildContext context}){
   return Column(
     children: [
       ListTile(
         leading: Container(width: 50,height: 50,color: Colors.red,),
         title: "Delivery on 22 jan".text.make(),
         subtitle: "Asx  360 degree Flexible Portable".text.softWrap(true).make(),
         trailing: IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_right)),
       ),
       10.heightBox,
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           "Rate & Review".text.make(),
           VxRating(
             count: 5,
             maxRating: 5,
             stepInt: true,
             onRatingUpdate: (val){},)
         ],
       ).box.green100.make()
     ],
   ).box.p12.white.width(context.screenWidth).make();
}