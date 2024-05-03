import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';

Widget discritionFeild({String? title,controller,String? hint}){
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.black).fontFamily(bold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        maxLines: 5,
        decoration: InputDecoration(
            hintStyle: TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: darkBlue
                )
            )
        ),
      ),
      5.heightBox
    ],
  );
}