import 'package:emartseller/Widgets/cart.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/notificationController.dart';
import 'package:emartseller/controller/orderController.dart';
import 'package:emartseller/screens/orderScreen/productStatus.dart';
import 'package:flutter/material.dart';

import '../../Widgets/orderCart.dart';

class PendingOrderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _pendindOrderScreen();

}

class _pendindOrderScreen extends State<PendingOrderScreen>{
  @override
  Widget build(BuildContext context) {
    var notiCon = Get.put(NotificationController());
    return Scaffold(
       body: StreamBuilder(stream: FirebaseSerice.getUpcomingOrder(),
           builder:(BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
               return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              return Center(child: "No data Found".text.make(),);
            }else{
              var data = snapshot.data!.docs;
             return ListView.builder(
                  itemBuilder: (context,index){
                 //   var token = notiCon.getCustomerToken(data[index]["order_by_id"]);
                    return UpcomingCart(
                   //   token: token,
                      time: data[index]["booking_date"],
                      img: data[index]["img"],
                      qty: data[index]["total_qty"],
                      price: data[index]["total_price"],
                      docId: data[index].id,
                        name: data[index]["order_name"],
                        PaymentType: data[index]["payment_method"],
                        context: context,
                    ).box.margin(const EdgeInsets.only(bottom: 5)).make().onTap(() {
                      Get.to(()=>ProductStatus(data: data[index],));
                    });;
                  },
                  itemCount: data.length);
            }
           })
    );
  }
}