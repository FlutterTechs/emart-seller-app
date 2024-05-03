import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
class PaymentHistoryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _paymentHistoryScreen();

}

class _paymentHistoryScreen extends State<PaymentHistoryScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: boldText(title: "Payment History",size: 20),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
    itemCount: 20,
    itemBuilder: (context,index){
          return ListTile(
          leading: CircleAvatar(backgroundColor: Colors.grey,),
          title: "Persone Name".text.make(),
          subtitle: "Yesterday 20:12".text.make(),
          trailing: boldText(title: "-\$800",size: 20),
          );
    }, separatorBuilder: (BuildContext context, int index) {
      return Divider(color: Colors.grey,);
        },)
    ));
  }
}