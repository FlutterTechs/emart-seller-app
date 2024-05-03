import 'package:emartseller/const/files.dart';

Widget insightButton({String? title,icon,String? value}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            title!.text.size(20).fontWeight(FontWeight.w700).wrapWords(true).make(),
         // Image.asset(icon,).box.make()
        ],
      ),
      10.heightBox,
      value!.text.size(40).fontWeight(FontWeight.w700).make(),
      10.heightBox
    ],
  ).box.color(darkBlue).shadow2xl.roundedLg.p20.make();
}