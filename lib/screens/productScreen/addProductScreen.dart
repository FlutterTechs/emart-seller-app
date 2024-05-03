import 'package:emartseller/Widgets/featuresView.dart';
import 'package:emartseller/Widgets/image.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/models/featureModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../Widgets/discription.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/addProductController.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';
class AddProductScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _addProduct();
}

class _addProduct extends State<AddProductScreen>{
  List<Color> colors = [const Color(0x00ff0000),const Color(0x000000ff),const Color(0x00808080),const Color(0x00008000),const Color(0x00ffffff),const Color(0x00ffc0cb),const Color(0x00ffff00),const Color(0x00000000),const Color(0x0000ffff),const Color(0x00a020f0),const Color(0x00add8e6),const Color(0x0ffa5000)];
  var addProductController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: boldText(title: "Add New Product",size: 20),
        backgroundColor: darkBlue,
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(12),
        child: Obx(
          () => addProductController.isloading.value ?
              const Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("..uploading",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),)
                ],
              ),)
          :SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Images".text.color(Colors.black).fontFamily(bold).size(16).make(),
                  (!addProductController.isImg.value || addProductController.images.isEmpty)?
                  Container(
                      width: double.infinity,
                      height: 100,
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(Icons.add)
                  ).onTap(() {
                    addProductController.Images();
                  }):SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(addProductController.images.length, (index){
              return imageView(
                  img: addProductController.images[index],
                  onpress: (){
                    addProductController.images.removeAt(index);
                    setState(() {
                      if(addProductController.images.isEmpty){
                        addProductController.isImg.value = false;
                      }
                    });
                  }
              ).box.margin(const EdgeInsets.only(right: 10)).make();
            }),
          ),
        )
            ,
                  customTextFeild(
                      controller: addProductController.nameCon,
                      title: "Title",
                      hint: "Product Name"
                  ),
                  customTextFeild(
                      controller: addProductController.priceCon,
                      title: "Price",
                      hint: "Price "
                  ),
                  customTextFeild(
                      controller: addProductController.BrandCon,
                      title: "Brand",
                      hint: "Brand name"
                  ),
                  discritionFeild(
                      controller: addProductController.descrptionCon,
                      title: "Description",
                      hint:" Product Details"
                  ),
                  customTextFeild(
                      controller: addProductController.quantityCon,
                      title: "Quantity",
                      hint: "Per peice"
                  ),

                  10.heightBox,
                  Row(
                    children: [
                      "Featured".text.color(Colors.black).fontFamily(bold).size(16).make(),
                      30.widthBox,
                      "No".text.make(),
                      Checkbox(
                          activeColor: darkBlue,
                          value: !addProductController.select.value,
                          onChanged: (val){
                            addProductController.select.value = false;
                          }),
                      30.widthBox,
                      "Yes".text.make(),
                      Checkbox(
                          activeColor: darkBlue,
                          value: addProductController.select.value,
                          onChanged: (val){
                            addProductController.select.value = true;
                          })
                    ],
                  ),
                  20.heightBox,
                  DropdownMenu(
                    label: const Text("Category"),
                      width: context.screenWidth - 70,
                      hintText: "Select category",
                      onSelected: (val){
                    addProductController.categoryId = int.parse(val!);
                    addProductController.subcategory.value = addProductController.subCatMaster.value.where((element) =>
                    element["ParentId"].toString() == val).toList();
                    addProductController.getCategory(int.parse(val!));
                      },
                      controller: addProductController.subcatCon,
                      dropdownMenuEntries: List.generate(addProductController.category.value.length, (index) {
                    return DropdownMenuEntry(value:addProductController.category.value[index]["id"].toString(),
                        label: addProductController.category.value[index]["label"].toString());
                  })),
                 20.heightBox,
                 DropdownMenu(
                     label: Text("Sub Category"),
                     width: context.screenWidth - 70,
                     hintText: "Select Sub category",
                     onSelected: (val){
                       addProductController.subcatCon.text = val;
                     },
                     dropdownMenuEntries: List.generate(
                  addProductController.subcategory.value.length,
                    (index) {
                    return DropdownMenuEntry(
                        value:addProductController.subcategory.value[index]["Name"] ,
                        label:addProductController.subcategory.value[index]["Name"]);
                  })),
                  20.heightBox,
                  "Features :".text.color(Colors.black).fontFamily(bold).size(16).make(),
                  5.heightBox,
                  addProductController.haveData.value?
                     Column(
                       children:
                       addProductController.productFeatures.value.map((e){
                         return Featuresview(
                           val: e.value,
                           key: e.keyName,
                           onpress: (){
                           int index  =  addProductController.productFeatures.indexOf(e);
                             addProductController.removeProductFeatures(index);
                             setState(() {

                             });
                           }
                         );
                       }).toList(),
                     )
                      :Container(),
                  TextButton(onPressed: (){
                    _showdialoge(context,addProductController.read);
                  }, child: const Text("add Features")),
                  20.heightBox,
                  "Colors : ".text.color(Colors.black).fontFamily(bold).size(16).make(),
                  SizedBox(
                    width: double.infinity,
                    child: MultipleChoiceBlockPicker(
                      availableColors: colors,
                      useInShowDialog: true,
                      onColorsChanged: (List<Color> colors){ //
                        addProductController.colors = colors.map((e){
                          return e.value.toString() ;
                        }).toList(); //
                      }, pickerColors: [],
                    ),
                  ),
                 ourButton(
                      title: "Upload",
                      color: darkBlue,
                      textColor: Colors.black,
                      onpress: (){
                          addProductController.uploadProduct();
                          setState(() {

                          });
                      }
                  ).box.width(context.screenWidth - 30).make()

                ],
              ),

          ),
        ),
      ),
    );
  }
  Future<void> _showdialoge(BuildContext context,read){
    return showDialog(
        context: context, builder: (BuildContext context){
      return SizedBox(
        height: 400,
        width: 200,
        child:AlertDialog(
          title: const Text("Add Features"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addProductController.Key ,
                decoration: const InputDecoration(
                  label: Text("Enter Key"),
                ),
              ),
              TextField(
                controller: addProductController.Value,
                decoration: const InputDecoration(
                  label: Text("Enter Value"),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(onPressed: (){
            if(addProductController.Key.text != "" && addProductController.Value.text != ""){
              addProductController.addProductFeatures(
                  Features(keyName: addProductController.Key.text,
                      value: addProductController.Value.text)

              );
              addProductController.Value.clear();
              addProductController.Key.clear();
              setState(() {

              });

            }
              Navigator.pop(context);
            }, child: Text("add")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel"))
          ],
        ),
      );
    });
  }

}