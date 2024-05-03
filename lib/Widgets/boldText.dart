import 'package:flutter/cupertino.dart';
import "package:velocity_x/velocity_x.dart";

Widget boldText({String? title, double size = 12}) {
  return title!.text.fontWeight(FontWeight.w700).size(size).black.make();
}
