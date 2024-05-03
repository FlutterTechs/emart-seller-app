import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/styles.dart';

Widget ourButton({String? title,onpress,color,textColor}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(12)
      ),
      onPressed: onpress,
      child: title!.text.color(textColor).fontFamily(semibold).make());
}