import 'package:emartseller/Widgets/dispact_cart.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/screens/orderScreen/productStatus.dart';
import 'package:emartseller/screens/productScreen/ViewProductScreen.dart';
import 'package:flutter/material.dart';

import '../../Widgets/cancelCart.dart';

class OrderCompleteScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _orderCompleteScreen();

}

class _orderCompleteScreen extends State<OrderCompleteScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseSerice.getReadyOrder(),
          builder:(BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              return Center(child: "No data Found".text.make(),);
            }else{
              var data = snapshot.data.docs;
              return ListView.builder(itemBuilder: (context,index){
                return dispactCart(
                  status: data[index]["is_order_on_delivery"],
                  paymentMethod: data[index]["payment_method"],
                  docId: data[index].id,
                  img: data[index]["img"],
                  qty: data[index]["total_qty"],
                    name: data[index]["order_name"],
                    price: data[index]["total_price"],
                    time: data[index]["booking_date"],
                    context: context).box.margin(const EdgeInsets.only(bottom: 5)).make().onTap(() {
                      Get.to(()=>ProductStatus(data: data[index],));
                });
              },
                itemCount: data.length,
              );
            }
          })
    );

 }
}