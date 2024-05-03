import 'package:cross_file/cross_file.dart';
import 'package:emartseller/models/featureModel.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:emartseller/const/files.dart';
import '../const/firebase_const.dart';
import 'package:path/path.dart';
import 'package:emartseller/const/files.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductController extends GetxController{
  List<File> images = [];
var  isImg = false.obs;
  List<String> uploadedImages = [];

  var nameCon = TextEditingController();
  var priceCon = TextEditingController();
  var descrptionCon = TextEditingController();
  var quantityCon = TextEditingController();
  var subcatCon = TextEditingController();
  var Key  = TextEditingController();
  var Value = TextEditingController();
  var BrandCon = TextEditingController();
  var mapData =[].obs;
  var read;

  var isFeatured = false.obs;
  var isloading = false.obs;
   String? sellerName = Get.find<AuthController>().sellername;

  List<String> colors = [];
  var categoryId ;
  Rx<int>? subCategoryId;
  var category = [
    {"id":1,"label":"Women Dress"},
    {"id":2,"label":"Men Clotings & Fashion"},
    {"id":3,"label":"Computer & Accessories"},
    {"id":4,"label":"Automobile"},
    {"id":5,"label":"Kids & Toys"},
    {"id":6,"label":"Sports"},
    {"id":7,"label":"Jewelley"},
    {"id":8,"label":"Furniture"},
    {"id":9,"label":"Cellphone & Tab"},
  ].obs;
  var subCatMaster = [
    {"ID":1,"Name":"Wedding & Event","ParentId":1},
    {"ID":2,"Name":"Tops & sets","ParentId":1},
    {"ID":3,"Name":"Outwear & Jackets","ParentId":2},
    {"ID":4,"Name":"Formal Dress","ParentId":2},
    {"ID":5,"Name":"Accessories","ParentId":2},
    {"ID":6,"Name":"Laptop","ParentId":3},
    {"ID":7,"Name":"Gaming PC","ParentId":3},
    {"ID":8,"Name":"Offical Equipment","ParentId":3},
    {"ID":9,"Name":"Cars","ParentId":4},
    {"ID":10,"Name":"Bikes","ParentId":4},
    {"ID":11,"Name":"Shoes & Bags","ParentId":5},
    {"ID":12,"Name":"Baby Clothing","ParentId":5},
    {"ID":13,"Name":"Girls Toys","ParentId":5},
    {"ID":14,"Name":"Footballs","ParentId":6},
    {"ID":15,"Name":"Bat","ParentId":6},
    {"ID":16,"Name":"jolf","ParentId":6},
    {"ID":17,"Name":"Necklace","ParentId":7},
    {"ID":17,"Name":"Gold","ParentId":7},
    {"ID":18,"Name":"Earing","ParentId":7},
    {"ID":19,"Name":"Bed","ParentId":8},
    {"ID":20,"Name":"Sofa","ParentId":8},
    {"ID":21,"Name":"Android Mobiles","ParentId":9},
    {"ID":22,"Name":"Tabs","ParentId":9},
    {"ID":23,"Name":"Iphones","ParentId":9},
    {"ID":24,"Name":"Watches","ParentId":9},

  ].obs;
  var subcategory = [].obs;
   var productFeatures = [].obs;
   var haveData = false.obs;
   addProductFeatures(Features data){
     haveData.value = true;
     productFeatures.value.add(data);
   }
   removeProductFeatures(index){
     if(index == 0){
       haveData.value = false;
     }
     productFeatures.value.removeAt(index);
   }
   var is_image_selected = false.obs;
  var dropValue = "".obs;
  getCategory(int id){
    for(int i = 0;i<category.value.length;i++){
        if(category.value[i]["id"] == id){
          dropValue.value = category.value[i]["label"].toString();
          print(dropValue.value);
        }
    }
  }
  late RxBool select = false.obs;
  Images() async{
    var pickImage = await ImagePicker().pickMultiImage(imageQuality: 70);
    if(pickImage != null){
      for(int i = 0;i<pickImage.length;i++){
        images?.add(File(pickImage[i].path));
      }
      isImg.value = true;
    }
  }

  uploadImage() async{
    try{
      List<String> filenames = [];
      for(int i = 0;i<images.length;i++){
        filenames.add(basename(images[i].toString()));
        var destination = "Images/${currentUser!.uid}/${filenames[i].toString()}";
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(File(images[i].path));
        var newImage = await ref.getDownloadURL();
        uploadedImages.add(newImage.toString());
      }
    }on PlatformException catch (e){
      Fluttertoast.showToast(msg: "Unable to upload Image");
    }
  }
  uploadProduct() async{
   isloading.value = true;
   if(images.isNotEmpty && nameCon.text.isNotEmpty && priceCon.text.isNotEmpty && descrptionCon.text.isNotEmpty && quantityCon.text.isNotEmpty && subcatCon.text.isNotEmpty
   && dropValue.value.isNotEmpty && colors.isNotEmpty){
     await uploadImage();
     await firestore.collection(products).doc().set({
       "p_name":nameCon.text,
       "p_price":priceCon.text,
       "p_image":FieldValue.arrayUnion(uploadedImages),
       "p_color":FieldValue.arrayUnion(colors),
       "vendor_id":currentUser?.uid,
       "wishlist":FieldValue.arrayUnion([]),
       "brand_name":BrandCon.text,
       "p_rating":"",
       "p_description":descrptionCon.text,
       "is_featured": select.value,
       "p_quantity": quantityCon.text,
       "Specification":FieldValue.arrayUnion(productFeatures.value.map((e) => e.toJson()).toList()),
       "p_seller":sellerName,
       "category":dropValue.value,
       "sub_category":subcatCon.text,
       "selles":0
     }).then((value) {
       Fluttertoast.showToast(msg: "Uploaded Successfully");
       Get.back();
     }).onError((error, stackTrace){
       print("Error while uploading");
       Get.back();
       print(error.toString());
     });
     isloading.value = false;
     disposeCon();
   }else{
     Fluttertoast.showToast(msg: "Failed");
     isloading.value = false;

   }
  }

@override
  void dispose() {
    // TODO: implement dispose
  disposeCon();
    super.dispose();
  }
  void disposeCon() {
   images.clear();
   nameCon.clear();
   priceCon.clear();
   descrptionCon.clear();
   quantityCon.clear();
   subcatCon.clear();
   isImg.value = false;
   dropValue.value = "";
   colors.clear();
  }
}