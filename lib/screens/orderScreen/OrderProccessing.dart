import 'package:emartseller/Widgets/PrendingCart.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/orderController.dart';
import 'package:emartseller/screens/orderScreen/productStatus.dart';
import 'package:flutter/material.dart';

import '../../Widgets/cart.dart';

class OrderProccessing extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _orderProccessing();
}

class _orderProccessing extends State<OrderProccessing>{
  @override
  Widget build(BuildContext context) {
    var orderController = Get.put(OrderController());
    return Scaffold(
      body: Obx(
          ()=> orderController.isloading.value ? Center(
            child: CircularProgressIndicator(),
          )  :StreamBuilder(stream: FirebaseSerice.getPendingOrder(),
            builder:(BuildContext context,AsyncSnapshot snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else if(snapshot.data!.docs.isEmpty){
                return Center(child: "No data Found".text.make(),);
              }else{
                var data = snapshot.data.docs;
                return ListView.builder(itemBuilder: (context,index){
                  return PendingCart(
                    time: data[index]["booking_date"],
                    img: data[index]["img"],
                     docId: data[index].id,
                     paymentMethod: data[index]["payment_method"],
                     price: data[index]["total_price"],
                      name: data[index]["order_name"],
                      btn: data[index]["invoice"].toString() == "" ?
                      TextButton(onPressed: (){
                        orderController.addInvoice(data[index].id,data[index]["order_by_id"],);
                      }, child: Text("Click to upload invoice"))
                          : Row(
                          children : [
                            "bill".text.green700.make() ,
                            IconButton(onPressed : (){
                              orderController.removeInvoice(url : data[index]["invoice"].toString(),docId : data[index].id);
                            },icon:Icon(Icons.cancel_outlined,color:Colors.red))
                          ]
                      ),
                      qty: data[index]["total_qty"],
                      context: context).box.margin(const EdgeInsets.only(bottom: 5)).make().onTap(() {
                    Get.to(()=>ProductStatus(data: data[index],));
                  });;
                },
                  itemCount: data.length,
                );

              }
            }),
      )
    );
  }
}