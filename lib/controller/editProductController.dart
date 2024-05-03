
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:emartseller/const/files.dart';
import 'package:image_picker/image_picker.dart';
import '../const/firebase_const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/featureModel.dart';
import 'package:emartseller/const/files.dart';
class EditProductCotroller extends GetxController{
  //we store complete product data in data variable
  dynamic data;
  var images = [];
  var localImage = [];
  var  isImg = false.obs;
  List<String> uploadedImages = [];

  var nameCon = TextEditingController();
  var priceCon = TextEditingController();
  var descrptionCon = TextEditingController();
  var quantityCon = TextEditingController();
  var subcatCon = TextEditingController();
  var Key  = TextEditingController();
  var Value = TextEditingController();
  var categoryCon = TextEditingController();
  var subCategoryCon = TextEditingController();
  var BrandCon = TextEditingController();
  var mapData =[].obs;
  var read;
  var isFeatured = false.obs;
  var isloading = false.obs;
  String? sellerName ="Reymond";
   var UploadColor;
  var colors = [];
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

  var is_image_selected = false.obs;
  var dropValue = "".obs;
  late RxBool select = false.obs;
  var dataId;
  setValue(data){
    isImg.value = true;
    dataId = data.id;
    images = data["p_image"];
    subCategoryCon.text = data["sub_category"].toString();
    categoryCon.text = data["category"].toString();
    dropValue.value = data["category"].toString();
    nameCon.text  = data["p_name"].toString();
    priceCon.text = data["p_price"].toString();
    descrptionCon.text = data["p_description"].toString();
    quantityCon.text = data["p_quantity"].toString();
    select.value = data["is_featured"];
    productFeatures.value = data["Specification"].toList();
    HaveFeatures();
    colors = data["p_color"];
    UploadColor = data["p_color"];
    BrandCon.text = data["brand_name"];

  }
  removeImages(String path,docId) async{
    if (kDebugMode) {
      print("path of image");
      print(path);

    }
    try{
      isloading(true);
      await firestore.collection(AuthController.productCollection).doc(docId).update({
        "p_image":FieldValue.arrayRemove([path.toString()])
      });
      await fireStorage.refFromURL(path).delete();
      if (kDebugMode) {
        print("image deleted");
      }
      isloading(false);

    }catch(e){
      isloading(true);
      if (kDebugMode) {
        print("deleting error:");
        print(e.toString());
      }
      isloading(false);

    }
  }
  HaveFeatures(){
    if(productFeatures.value.isNotEmpty){
      haveData.value = true;
    }
  }
  addProductFeatures(Features data) async{
    haveData.value = true;
    productFeatures.value.add(data.toJson());
    await firestore.collection(AuthController.productCollection).doc(dataId).update({
      "Specification":FieldValue.arrayUnion([data.toJson()]),

    });
  }
  removeProductFeatures(index,data) async{
    if(index == 0){
      haveData.value = false; 
    }
    await firestore.collection(AuthController.productCollection).doc(dataId).update({
      "Specification":FieldValue.arrayRemove([data]),
    });
    productFeatures.value.remove(data);
  }
  Images(docId) async{
    isloading(true);
    var pickImage = await ImagePicker().pickMultiImage(imageQuality: 70);
    if(pickImage != null){
      for(int i = 0;i<pickImage.length;i++){
        localImage?.add(File(pickImage[i].path));
      }
      await uploadImage();
      await firestore.collection(AuthController.productCollection).doc(docId).update({
        "p_image":FieldValue.arrayUnion(images),
      }).whenComplete((){
        isloading(false);
        isImg.value = true;
      });
    }
  }

  uploadImage() async{
    try{
      List<String> filenames = [];
      for(int i = 0;i<localImage.length;i++){
        filenames.add(basename(localImage[i].toString()));
        var destination = "Images/${currentUser!.uid}/${filenames[i].toString()}";
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(File(localImage[i].path));
        var newImage = await ref.getDownloadURL();
        images.add(newImage.toString());
      }
    }on PlatformException catch (e){
      Fluttertoast.showToast(msg: "Unable to upload Image");
    }
  }
  getCategory(int id){
    for(int i = 0;i<category.value.length;i++){
      if(category.value[i]["id"] == id){
        dropValue.value = category.value[i]["label"].toString();
        print(dropValue.value);
      }
    }
  }
  uploadUpdatedProduct(docId) async{
    print(productFeatures.value);
    isloading.value = true;
     await firestore.collection(products).doc(docId).update({
        "p_name":nameCon.text,
        "p_price":priceCon.text,
        "p_color":FieldValue.arrayUnion(UploadColor),
        "p_description":descrptionCon.text,
        "is_featured": select.value,
        "p_quantity": quantityCon.text,
        "category":dropValue.value,
        "sub_category":subcatCon.text,
        "brand_name":BrandCon.text
      }).then((value) {
        isloading(false);
        Fluttertoast.showToast(msg: "Uploaded Successfully");
        Get.back();
      }).onError((error, stackTrace){
        print("Error while uploading");
        print(error.toString());
      });
      isloading.value = false;
      if (kDebugMode) {
        print("Uploaded");
        print(images.toList());
        print(nameCon.text);
        print(descrptionCon.text);
        print(quantityCon.text);
        print(dropValue);
        print(subCategoryCon.text);
        print(select.value);
        print(productFeatures);
        print(UploadColor);
      }
      disposeCon();
  }

  @override
  void dispose() {
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
