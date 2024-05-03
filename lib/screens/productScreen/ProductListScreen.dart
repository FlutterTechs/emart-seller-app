import 'package:emartseller/Widgets/shimmerList.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/screens/productScreen/editProductScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Widgets/ProductViewCart.dart';
import '../../controller/productListController.dart';
import 'addProductScreen.dart';

class ProductListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState () => _productListScreen();
}

class _productListScreen extends State<ProductListScreen>{
  var productListController = Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: boldText(size: 25,title: "Products"),
      ),
      body:  Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseSerice.getOurProduct(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return ShimmerList();
                  }else if(snapshot.data!.docs.isEmpty){
                    return Center(child: "No Data Found".text.make(),);
                  }else{
                    var data = snapshot.data!.docs;
                    print(data);
                    return Obx(
                      ()=> Expanded(
                        child: productListController.isLoading.value ? Opacity(
                          opacity: 0.9,
                          child: Container(
                            width: context.screenWidth,
                            height: context.screenHeight,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ): ListView.separated(
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return ProductViewCart(
                              isfeatured: data[index]["is_featured"],
                                price: data[index]["p_price"],
                                name: data[index]["p_name"],
                                img: data[index]["p_image"][0],
                                context: context,
                                onDelete: (){
                                Navigator.pop(context);
                                  productListController.deleteList(data[index].id);
                                },
                                onEdit: () {
                                  Navigator.pop(context);
                                  Get.to(()=>EditProductScreen(
                                    data: data[index],
                                  ));

                                },
                                onFeatured: (){
                                  Navigator.pop(context);
                                  productListController.FeaturedList(
                                    data: data[index],
                                    docId: data[index].id
                                  );
                                  setState(() {

                                  });
                                }
                            ).box.shadow.white.make();
                          }, separatorBuilder: (BuildContext context,int index) {
                          return Divider();
                        },),
                      ),
                    );

                  }
                })
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Colors.grey,
          elevation: 5,
          fixedSize: Size(70, 70),

        ),
          onPressed: (){
          Get.to(()=>AddProductScreen());
          }, child: Icon(Icons.add,color: Colors.black,)),
    );
  }
}