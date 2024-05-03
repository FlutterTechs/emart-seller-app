import 'package:emartseller/const/files.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProductScreen extends StatefulWidget{
  final dynamic data;
  final String title;
  const ProductScreen({super.key, required this.data, required this.title});
  @override
  State<StatefulWidget> createState() => _product_Screen(data,title);
}

class _product_Screen extends State<ProductScreen>{
  final dynamic data;
  final String title;

  _product_Screen(this.data, this.title);
  @override
  Widget build(BuildContext context) {
    print(data["p_name"]);
    return PopScope(
      canPop: true,
      child: Scaffold(backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: title.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: Padding(padding: EdgeInsets.all(12),
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          height: context.screenHeight / 2.5,
                          aspectRatio: 16/9,
                          itemCount: data["p_image"].length,
                          enlargeCenterPage: true,
                          itemBuilder: (context,index){
                            return Image.network(
                              data["p_image"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      title.text.fontFamily(semibold).size(18).color(darkFontGrey).make(),
                      10.heightBox,
                      VxRating(
                        value: double.parse(data["p_rating"]),
                        maxRating: 5,
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        size: 25,
                        onRatingUpdate: (String value) {
                        },
                      ),
                      10.heightBox,
                      "${data["p_price"]}".numCurrency.text.fontFamily(semibold).color(Colors.black).make(),
                      10.heightBox,
                      Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            ListTile(
                             // title: seller.text.make(),
                              subtitle: "${data["p_seller"]}".text.make(),
                              trailing: Icon(Icons.message),
                              onTap: (){
                              //  Get.to(()=>ChatScreen(title:"${data["p_seller"]}"),arguments: [data["p_seller"],data["vendor_id"]]);
                              },
                            ).box.color(Colors.grey).make(),
                            Obx(
                                  ()=> ListTile(
                           //     title: quantity.text.make(),
                                trailing: VxStepper(
                             //     defaultValue: controller.total_quantity.value,
                                  min: 1,
                                  max: 100,
                                  actionButtonColor: redColor,
                                  onChange: (val){
                                 //   controller.total_price.value = int.parse(data['p_price']);
                                //    controller.changeQuantity(val);
                                  },
                                ),
                              ),
                            ),
                            Obx(()  {
                              return ListTile(
                              //  title: totalPrice.text.make(),
                        //        trailing: "${controller.total_price.value}".text.color(darkFontGrey).make(),
                              ).box.color(Colors.amberAccent.shade100).make();
                            }
                            ),

                          ],
                        ),
                      ),
                      10.heightBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       //   discription.text.fontFamily(bold).color(darkFontGrey).size(18).make(),
                          5.heightBox,
                          Text("${data["p_discription"]}",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),softWrap: true,)

                        ],

                      ).p8().card.elevation(2).make().box.width(double.infinity).make(),
                      10.heightBox,

                      10.heightBox,
                      //   productYouAlosLike.text.fontFamily(bold).size(18).color(Colors.black).make(),
                      10.heightBox,
                      20.heightBox

                    ],
                  ),

                )
                ,)),
              10.heightBox

            ],
          ),
        ),
      ),
    );
  }
}