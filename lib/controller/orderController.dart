import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:emartseller/const/files.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../const/firebase_const.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
class OrderController extends GetxController{
   var isloading = false.obs;
  var is_confirmed = false.obs;
  var is_ready = false.obs;
  var is_dispatch = false.obs;
  orderConfirmed(docId) async{
    await firestore.collection(AuthController.orderCollection).doc(docId).update({
      "is_order_confirmed":true
    });
  }
  orderRejected(docId) async{
    await firestore.collection(AuthController.orderCollection).doc(docId).update({
      "is_order_rejected":true
    });
  }
  orderReady(docId) async{
    await firestore.collection(AuthController.orderCollection).doc(docId).update({
      "is_order_ready":true
    });
  }
  orderDispatch(docId) async{
    await firestore.collection(AuthController.orderCollection).doc(docId).update({
      "is_order_on_delivery":true
    });
  }
 late File invoice;
  addInvoice(String orderId,String userId) async{
    var result = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
    if(result != null){
      print("path");
      print(result);
      invoice = File(result.path.toString());
      uploadInvoice(invoice, orderId, userId);
    }
  }
  uploadInvoice(File file,String orderId,String userId) async{
   try{
     print("i am intry");
     isloading(true);
     var destination = "${userId}/${orderId}/${file.path}";
     print("i am intry");
     Reference ref =  fireStorage.ref().child(destination);
     print("i am intry");
     await ref.putFile(file);
     var getInvoiceUrl = await ref.getDownloadURL();
     firestore.collection(AuthController.orderCollection).doc(orderId).update({
       "invoice":getInvoiceUrl.toString()
     });
     isloading(false);

   }catch(e){
     print("error:");
     print(e);
     Fluttertoast.showToast(msg: "Unable to upload invoice");
   }
  }

  dynamic productData;
  removeInvoice({String? url,String? docId})async{
    try{
      isloading(true);
      firestore.collection(AuthController.orderCollection).doc(docId).update({
        "invoice":""
      });
      await fireStorage.refFromURL(url!).delete();
      isloading(false);
    }catch (e){
       Fluttertoast.showToast(msg: "Unable to delete invoice");
    }
  }

  /*
  data[index]["invoice"] != "" ?
    TextButton(onPressed: (){
      orderController.addInvoice(data[index].id,data[index]["order_by_id"],);
    }, child: Text("Click to upload invoice"))
   : Row(
  children : [
  "bill".text.green.make() ,
  IconButton(onPressed : (){
    orderController.removeInvoice(url : data[index]["invoice"].toString(),docId : data.id);
  },icon:Icon(Icons.minus,color:Colors.red))
  ]
  )
   */
}