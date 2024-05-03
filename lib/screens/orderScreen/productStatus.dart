import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
import 'package:emartseller/const/files.dart';
import 'package:velocity_x/velocity_x.dart';
class ProductStatus extends StatelessWidget{
  dynamic data;
  ProductStatus({super.key,required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Product Status".text.make(),
        backgroundColor: darkBlue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: "Product Status:".text.make(),
            trailing: data["is_order_confirmed"] ? (data["is_order_ready"] ? (data["is_order_dispatched"] ? "order Dispatched".text.green700.make():"order ready to dispatch".text.yellow700.make()): "Order not ready".text.yellow700.make() ):"New Order".text.green700.make()
          ),
          ListTile(
            title: "Product image:".text.make(),
            trailing: Image.network(data["img"]),
          ),
          ListTile(
            title: "Product Name".text.make(),
            trailing: data["order_name"].toString().text.wrapWords(true).make().box.width(context.screenWidth /3 ).make(),
          ),
          ListTile(
            title: "QTY:".text.make(),
            trailing: data["total_qty"].toString().text.make(),
          ),
          ListTile(
            title: "Price:".text.make(),
            trailing: data["total_price"].toString().text.make(),
          ),
          ListTile(
            title: "Address:".text.make(),
            trailing: Text(
              " Cutomer Name : ${data["order_by_name"]} \n${data["order_by_address"]} ${data["order_by_landmark"]} \n ${data["order_by_city"]}"
                  " ${data["order_by_pincode"]} ${data["order_by_state"]} ${data["contact_number"]}"
            ),
          ),
          ListTile(
            title: "Color:".text.make(),
            trailing: Container(
              width: 50,
              height: 50,
              color: Color(int.parse(data['color'].toString())),
            )
          ),
          ListTile(
            title: "Payment Type:".text.make(),
            trailing: data["payment_method"].toString().text.make(),
          ),
          ListTile(
            title: "Delivery At:".text.make(),
            trailing: data["shipment_type"].toString().text.make(),
          ),
          ListTile(
            title: "Order Id:".text.make(),
            trailing: data.id.toString().text.make(),
          ),
          ListTile(
            title: "Product Barcode:".text.make(),
          ),
          BarcodeWidget(
            barcode: Barcode.aztec(), // Barcode type and settings
            data: data.id.toString(), // Content
            width: 200,
            height: 200,
          ),
          40.heightBox
        ],
      ),
    );
 }

}