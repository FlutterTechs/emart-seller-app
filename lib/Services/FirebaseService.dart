import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/chatController.dart';import '../const/firebase_const.dart';

class FirebaseSerice {

  static getUserData(){
    return firestore.collection(vendorCollection).doc(currentUser!.uid).snapshots();
  }
  static getShopData(){
    return firestore.collection(shop).where("user_id",isEqualTo: currentUser!.uid).get();
  }

  static getOurProduct(){
    return firestore.collection(AuthController.productCollection).where("vendor_id",isEqualTo: currentUser!.uid).snapshots();
  }

  static getOrders(){
    return firestore.collection(AuthController.orderCollection).where("vendor_id",isEqualTo: currentUser!.uid).snapshots();
  }
  static getUpcomingOrder(){
    return firestore.collection(AuthController.orderCollection).where(Filter
    .and(Filter("vendor_id",isEqualTo: currentUser!.uid),Filter("is_order_placed",isEqualTo: true),Filter("is_order_confirmed",isEqualTo: false),Filter("is_order_cancel",isEqualTo: false),Filter("is_order_rejected",isEqualTo: false))).snapshots();
  }
  static getPendingOrder(){
    return firestore.collection(AuthController.orderCollection).where(
      Filter.and(Filter("vendor_id",isEqualTo: currentUser!.uid),Filter("is_order_confirmed",isEqualTo: true),Filter("is_order_ready",isEqualTo: false),Filter("is_order_cancel",isEqualTo: false))
    ).snapshots();
  }
  static getReadyOrder(){
    return firestore.collection(AuthController.orderCollection).where(Filter
        .and(Filter("vendor_id",isEqualTo: currentUser!.uid),Filter("is_order_ready",isEqualTo: true),Filter("is_order_cancel",isEqualTo: false))).snapshots();
  }
  static getDispatchOrder(){
    return firestore.collection(AuthController.orderCollection).where(Filter
        .and(Filter("vendor_id",isEqualTo: currentUser!.uid),Filter("is_order_on_delivery",isEqualTo: true),Filter("is_order_delivered",isEqualTo: false))).snapshots();
  }
  static OrderStatus(){
    return firestore.collection(AuthController.orderCollection).where(Filter
        .and(Filter("vendor_id",isEqualTo: currentUser!.uid),Filter.or(Filter("is_order_delivered",isEqualTo: true),Filter("order_canceled",isEqualTo: true)))).snapshots();
  }

  static cancelOrder(){
    return firestore.collection(AuthController.orderCollection).where("is_order_cancel",isEqualTo: true).snapshots();
  }


  static getCount() async{
    var res = await Future.wait([
      firestore.collection(AuthController.productCollection).where("vendor_id",isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(AuthController.orderCollection).where("vendor_id",arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(AuthController.productCollection).where("wishlist",arrayContains: currentUser! .uid).get().then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static GetAllChats(){
    return firestore.collection(chatsCollection).where("toId",isEqualTo: currentUser!.uid).snapshots();
  }
  static GetMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messageCollection).orderBy("created_on",descending: false).snapshots();
  }
  static getProductById(id){
    return firestore.collection(AuthController.productCollection).doc(id).get();
  }
  static getLastMsg({docIds,lastMsgId}){
    return firestore.collection(chatsCollection).doc(docIds).collection(messageCollection).doc(lastMsgId).snapshots();
  }

}