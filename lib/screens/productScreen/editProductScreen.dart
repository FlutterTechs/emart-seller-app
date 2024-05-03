import 'dart:io';

import 'package:emartseller/Widgets/image.dart';
import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/editProductController.dart';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../Widgets/discription.dart';
import '../../Widgets/editImageView.dart';
import '../../Widgets/featuresView.dart';
import '../../controller/addProductController.dart';
import '../../models/featureModel.dart';
class EditProductScreen extends StatefulWidget{
  dynamic data;
  EditProductScreen({super.key,this.data});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _editScreen(data);
}

// ignore: camel_case_types
class _editScreen extends State<EditProductScreen>{
  List<Color> colors = [const Color(0x00ff0000),const Color(0x000000ff),const Color(0x00808080),const Color(0x00008000),const Color(0x00ffffff),const Color(0x00ffc0cb),const Color(0x00ffff00),const Color(0x00000000),const Color(0x0000ffff),const Color(0x00a020f0),const Color(0x00add8e6),const Color(0x0ffa5000)];
  var editController =  Get.put(EditProductCotroller());
  dynamic data;
   _editScreen(this.data);
   @override
  void initState() {
    // TODO: implement initState
     editController.setValue(data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: boldText(title: "Edit Product",size: 20),
        backgroundColor: darkBlue,
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Obx(
            ()=> (editController.isloading.value || data["p_image"].isEmpty )?  const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("..updating",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                  ),)

                ],
              ),
            ) :Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Images".text.color(Colors.black).fontFamily(bold).size(16).make(),
                (!editController.isImg.value || editController.images.isEmpty) ?
                Container(
                    width: double.infinity,
                    height: 100,
                    margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add)
                ).onTap(() {
                  editController.Images(data.id);
                }):SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(editController.images.length, (index){
                      return EditimageView(
                          img: editController.images[index].toString(),
                          onpress: (){
                            editController.removeImages(editController.images[index].toString(),data.id);
                            editController.images.removeAt(index);
                            setState(() {
                              if(editController.images.isEmpty){
                                editController.isImg.value = false;
                              }
                            });
                          }
                      ).box.margin(const EdgeInsets.only(right: 10)).make();
                    }),
                  ),
                )
                ,
                customTextFeild(
                  controller: editController.nameCon,
                    title: "Title",
                    hint: "Product Name"
                ),
                customTextFeild(
                    controller: editController.priceCon,
                    title: "Price",
                    hint: "Price "
                ),
                customTextFeild(
                    controller: editController.priceCon,
                    title: "Brand",
                    hint: "Brand name"
                ),
                discritionFeild(
                    controller: editController.descrptionCon,
                    title: "Description",
                    hint:" Product Details"
                ),
                customTextFeild(
                    controller: editController.quantityCon,
                    title: "Quantity",
                    hint: "Per peice"
                ),
                10.heightBox,
                Row(
                  children: [
                    "Featured".text.color(Colors.black).fontFamily(bold).size(16).make(),
                    30.widthBox,
                    "Yes".text.make(),
                    Checkbox(
                        activeColor: darkBlue,
                        value: !editController.select.value,
                        onChanged: (val){
                      editController.select.value = false;
                    }),
                    30.widthBox,
                    "No".text.make(),
                    Checkbox(
                        activeColor: darkBlue,
                        value: editController.select.value, onChanged: (val){
                      editController.select.value = true;

                    })
                  ],
                ),
                DropdownMenu(
                    controller: editController.categoryCon,
                    label: const Text("Category"),
                    width: context.screenWidth - 70,
                    hintText: "Select category",
                    onSelected: (val){
                      editController.categoryId = int.parse(val!);
                      editController.subcategory.value = editController.subCatMaster.value.where((element) =>
                      element["ParentId"].toString() == val).toList();
                      editController.getCategory(int.parse(val!));
                      if (kDebugMode) {
                        print(val);
                      }
                    },
                    dropdownMenuEntries: List.generate(
                        editController.category.value.length, (index) {
                      return DropdownMenuEntry(value:editController.category.value[index]["id"].toString(),
                          label: editController.category.value[index]["label"].toString());
                    })),
                20.heightBox,
                DropdownMenu(
                  controller: editController.subCategoryCon,
                    label: const Text("Sub Category"),
                    width: context.screenWidth - 70,
                    hintText: "Select Sub category",
                    onSelected: (val){
                    print(val);
                      editController.subcatCon.text = val;
                    },
                    dropdownMenuEntries: List.generate(
                        editController.subcategory.value.length,
                            (index) {
                          return DropdownMenuEntry(
                              value:editController.subcategory.value[index]["Name"] ,
                              label:editController.subcategory.value[index]["Name"]);
                        })),
                20.heightBox,
                "Features :".text.color(Colors.black).fontFamily(bold).size(16).make(),
                5.heightBox,
              editController.haveData.value ?
                Column(
                  children:
                  editController.productFeatures.value.map((e){
                    return Featuresview(
                        val: e["value"],
                        key: e["keyName"],
                        onpress: (){
                          int index  =  editController.productFeatures.indexOf(e);
                          editController.removeProductFeatures(index,e);
                          setState(() {

                          });
                        }
                    );
                  }).toList(),
                )
                    :Container(),
                TextButton(onPressed: (){
                  _showdialoge(context,editController.read);
                }, child: const Text("add Features")),
                "Colors : ".text.color(Colors.black).fontFamily(bold).size(16).make(),
                SizedBox(
                  width: double.infinity,
                  child: MultipleChoiceBlockPicker(
                    availableColors: colors,
                    useInShowDialog: true,
                    pickerColors: editController.colors.map((e) {
                      return Color(int.parse(e.toString()));
                    }).toList() , //default color
                    onColorsChanged: (List<Color> colors){ //
                      print(colors);
                      editController.UploadColor = colors.map((e) {
                        return e.value.toString();
                      }).toList();
                      if (kDebugMode) {
                        print(editController.UploadColor);
                      }
                    },
                  ),
                ),
                ourButton(
                    title: "Update",
                    color: darkBlue,
                    textColor: Colors.black,
                    onpress: (){
                   editController.uploadUpdatedProduct(data.id);
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
                controller: editController.Key ,
                decoration: const InputDecoration(
                  label: Text("Enter Key"),
                ),
              ),
              TextField(
                controller: editController.Value,
                decoration: const InputDecoration(
                  label: Text("Enter Value"),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(onPressed: (){
              if(editController.Key.text != "" && editController.Value.text != ""){
                editController.addProductFeatures(
                    Features(keyName: editController.Key.text,
                        value: editController.Value.text)
                );
                if (kDebugMode) {
                  print(editController.productFeatures);
                }
                editController.Value.clear();
                editController.Key.clear();
                setState(() {

                });

              }
              Navigator.pop(context);
            }, child: const Text("add")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Cancel"))
          ],
        ),
      );
    });
  }

}