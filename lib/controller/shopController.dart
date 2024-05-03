import 'package:emartseller/const/files.dart';

class ShopController extends GetxController{
  var shopnameCon = TextEditingController();
  var contactCon = TextEditingController();
  var gstCon = TextEditingController();
  var addressCon = TextEditingController();
  var landmarkCon = TextEditingController();
  var pincodeCon = TextEditingController();
  var countryCon = TextEditingController();
  var stateCon = TextEditingController();
  var cityCon = TextEditingController();
  var websiteCon = TextEditingController();
  convertData(data){
    shopnameCon.text = data["name"];
    contactCon.text = data["contact_number"];
    addressCon.text = data["address"];
    countryCon.text = data["country"];
    stateCon.text = data["state"];
    cityCon.text = data["city"];
    gstCon.text = data["gst_number"];
    landmarkCon.text = data["landmark"];
    pincodeCon.text = data["pincode"];


  }
}