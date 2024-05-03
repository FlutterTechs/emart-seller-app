 import 'dart:io';

import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/addProductController.dart';
import 'package:emartseller/screens/productScreen/addProductScreen.dart';
import 'package:flutter/material.dart';

Widget imageView({File? img,onpress}){
  return Container(
    width: 100,
    height: 100,
    child: Stack(
      children: [
        Container(
          color: Colors.red,
          child: Image.file(img!,height: 100,width: 100,),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(onPressed: onpress, icon: Icon(Icons.cancel_outlined),),
        ),

      ],
    ),
  );
}
 