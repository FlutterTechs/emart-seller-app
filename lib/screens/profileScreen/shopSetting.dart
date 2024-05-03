import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/shopController.dart';
import 'package:flutter/material.dart';

import '../../Widgets/disableTextFeild.dart';

class ShopSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _shopSetting();
}

class _shopSetting extends State<ShopSetting> {
  @override
  Widget build(BuildContext context) {
    var shopController = Get.put(ShopController());
    return Scaffold(
      appBar: AppBar(
        title: boldText(title: "Shop Details", size: 20),
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:FutureBuilder(future: FirebaseSerice.getShopData(),
              builder:(BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
               return  Center(child: CircularProgressIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
               return Center(child: "No data Found".text.make(),);
            }else{
               shopController.convertData(snapshot.data!.docs.single);
              return Column(
                children: [
                  disableTextFeild(controller: shopController.shopnameCon,title: "Shop Name", hint: "Shop Name"),
                  disableTextFeild(controller: shopController.contactCon
                      ,title: "Cotact Number", hint: "Phone Number"),
                  disableTextFeild(controller:shopController.gstCon ,title: "GST", hint: "GST number"),
                  disableTextFeild(controller: shopController.addressCon,title: "Address", hint: "Street Name"),
                  disableTextFeild(controller: shopController.landmarkCon,title: "Landmark", hint: "Lankmark Name"),
                  disableTextFeild(controller:shopController.pincodeCon ,title: "Pincode", hint: "Postal address"),
                  disableTextFeild(controller: shopController.countryCon,title: "Country", hint: "Country Name"),
                  disableTextFeild(controller:shopController.stateCon ,title: "State", hint: "State Name"),
                  disableTextFeild(controller:shopController.cityCon ,title: "City", hint: "City Name"),
                  disableTextFeild(controller: shopController.websiteCon,title: "WebSite", hint: "Website Link"),
                ],
              );
            }
          })
        ),
      ),
    );
  }
}
