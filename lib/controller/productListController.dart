import 'package:emartseller/const/files.dart';
import 'package:emartseller/const/firebase_const.dart';

class ProductListController extends GetxController{
  var isLoading = false.obs;
  deleteList(docId) async{
    isLoading(true);
    await firestore.collection(AuthController.productCollection).doc(docId).delete();
    isLoading(false);
  }
  FeaturedList({docId,data}) async{
    isLoading(true);
    if(data["is_featured"] == false){
      await firestore.collection(AuthController.productCollection).doc(docId).update({
        "is_featured":true
      });
    }else{
      await firestore.collection(AuthController.productCollection).doc(docId).update({
        "is_featured":false
      });
    }
    isLoading(false);
  }
}