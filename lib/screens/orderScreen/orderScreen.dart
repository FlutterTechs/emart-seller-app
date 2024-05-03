import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/orderController.dart';
import 'package:emartseller/screens/orderScreen/pendingOrderScreen.dart';
import 'package:flutter/material.dart';

import 'OrderProccessing.dart';
import 'orderCancelScreen.dart';
import 'orderCompelteScreen.dart';


class OrderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _orderScreen();

}

class _orderScreen extends State<OrderScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(length: 4, child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: lightBlue,
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.history), text: "Pending\n Order",height: 100,),
                    Tab(icon: Icon(CupertinoIcons.cube_box), text: "  Order\nProccess",height: 100),
                    Tab(icon: Icon(Icons.done_all), text: "complete",height: 100),
                    Tab(icon: Icon(Icons.delivery_dining), text: "order \nStatus",height: 100),


                  ],
                ),
              ),
              body: TabBarView(children: [
                PendingOrderScreen(),
                OrderProccessing(),
               OrderCompleteScreen(),
               OrderCancelScreen()
              ]),
            )),
          )
        ],
      ),
    );
  }
}