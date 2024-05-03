import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';

import '../../Widgets/cancelCart.dart';
class OrderCancelScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _orderCancelScreen();

}

class _orderCancelScreen extends State<OrderCancelScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseSerice.OrderStatus(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: "No data Found".text.make(),);
          }else{
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context,index){
               return StatusCart(
                   time: data[index]["booking_date"],
                title: data[index]["order_name"],
                 address: data[index]["order_by_address"],
                 status: !data[index]["is_order_cancel"]
               ).box.white.margin(const EdgeInsets.only(top: 8)).shadow.width(context.screenWidth-70).make();
            });
          }
          })
    );
  }
}