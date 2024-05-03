import 'package:flutter/material.dart';

import '../const/files.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerBox(BuildContext context){
  return SizedBox(
    width: double.infinity,
    child: Shimmer.fromColors(baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade300,child:
      GridView.builder(
        shrinkWrap: true,
        itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2),
          itemBuilder: (context,index){
            return Container(
              width:  context.screenWidth / 2.5,
              height: 100,
              color: Colors.white,
            );
          }),
    ),
  );
}