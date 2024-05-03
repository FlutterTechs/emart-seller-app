import 'package:emartseller/Widgets/ShimmerBox.dart';
import 'package:emartseller/Widgets/shimmerList.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/screens/productScreen/editProductScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Widgets/boldText.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _home();

}

class _home extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        automaticallyImplyLeading: false,
        leading: Icon(Icons.dashboard,color: Colors.blue,size: 40,),
        title: Text("Dashboard"),
        titleSpacing: 2,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            FutureBuilder(
                 future: FirebaseSerice.getCount(),
                 builder: (BuildContext context,AsyncSnapshot snapshot){
                  var data = snapshot.data;
                  if(!snapshot.hasData){
                   return ShimmerBox(context);
                  //  return CircularProgressIndicator();
                  }else if(snapshot.data.isEmpty){
                    return Center(child: "NO Data Found".text.make(),);
               } else{
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: context.screenWidth /2.5,
                              padding: const EdgeInsets.all(20),
                              height: 100,
                              color: darkBlue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(CupertinoIcons.cube_box,size: 40,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      "Products".text.bold.size(15).make(),
                                      Text(data[0].toString()).box.makeCentered()
                                    ],
                                  )
                                ],
                              ),
                            ).card.elevation(12).make(),
                            Container(
                              padding: const EdgeInsets.all(20),
                              width: context.screenWidth /2.5,
                              height: 100,
                              color: darkBlue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.insights,size: 40,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      "Orders".text.bold.size(15).make(),
                                      Text(data[1].toString()).box.makeCentered()
                                    ],
                                  )
                                ],
                              ),
                            ).card.elevation(12).make(),

                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),

                              width: context.screenWidth /2.5,
                              height: 100,
                              color: darkBlue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(CupertinoIcons.heart_fill,size: 40,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      "Likes".text.bold.size(15).make(),
                                      Text(data[2].toString()).box.makeCentered()
                                    ],
                                  )
                                ],
                              ),
                            ).card.elevation(12).make(),
                            Container(
                              padding: const EdgeInsets.all(20),

                              width: context.screenWidth /2.5,
                              height: 100,
                              color: darkBlue,
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(CupertinoIcons.star,size: 40,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      "Rating".text.bold.size(15).make(),
                                      Text("00").box.makeCentered()
                                    ],
                                  )
                                ],
                              ),
                            ).card.elevation(12).make(),

                          ],
                        ),
                      ],
                    );

                  }
                 }),
              10.heightBox,
              "Top Products".text.size(20).bold.make(),
              10.heightBox,
              StreamBuilder(
                       stream: FirebaseSerice.getOurProduct(),
                       builder: (BuildContext context,AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return ShimmerList();
                          }else if(snapshot.data!.docs.isEmpty){
                             return "No Product available".text.makeCentered();
                          }else{
                             var data = snapshot.data!.docs;
                             return Container(
                               child: ListView.separated(
                                   physics: NeverScrollableScrollPhysics(), //diables the scrolling
                                   shrinkWrap: true,
                                   itemBuilder: (context,index){
                                     return ListTile(
                                      leading: SizedBox(
                                         width: 100,
                                         height: 100,
                                         child: Image.network(data[index]["p_image"][0]),
                                       ),
                                       title: Text(data[index]["p_name"].toString()),
                                       subtitle: "Qty: ${data[index]["p_quantity"]}".text.make(),
                                       trailing: Text("\u20B9 ${data[index]["p_price"]}"),
                                     ).box.shadowSm.white.make().onTap(() {
                                       Get.to(()=>EditProductScreen(data: data[index],));
                                     });
                                   },
                                   separatorBuilder: (context,index){
                                     return const Divider();
                                   },
                                   itemCount: data.length),
                             );
                          }
                       }),
            ],
          ),
        ),
      )
    );
  }
}