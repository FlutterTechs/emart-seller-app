import 'dart:ffi';

import 'package:emartseller/const/files.dart';
import 'package:emartseller/controller/addProductController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget Featuresview({String? key,String? val,onpress}){
  return Row(
    children: [
      Expanded(
        flex: 1,
          child: Text(key!)),
      Expanded(
          flex: 1,
          child: Text(val!)),
      IconButton(onPressed: onpress, icon: const Icon(Icons.delete))
    ],
  );
}
