import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../const/files.dart';

Widget ProductViewCart({required BuildContext context,required String img,required String price,required String name,onEdit,onFeatured,onDelete,required bool isfeatured}){
return ListTile(
  leading: Image.network(img,height: 100,width: 100,),
  title: "$name".text.make(),
  subtitle: "\u20B9 $price".text.bold.make(),
  trailing: PopupMenuButton(
    padding: const EdgeInsets.all(0.0),
    itemBuilder: (context) => [
      // popupmenu item 1
      PopupMenuItem(
          child:ListTile(
            onTap: onEdit ,
            leading: Icon(Icons.edit),
            title: Text("Review & Edit"),
          )
      ),
      // popupmenu item 2
      PopupMenuItem(
          child: ListTile(
            tileColor: isfeatured ? Colors.green : Colors.yellow,
            title: Text("Featured"),
            leading: Icon(Icons.star),
            onTap: onFeatured,
          )
      ),
      // popupmenu item 3
      PopupMenuItem(
          child:ListTile(
            leading: Icon(Icons.delete),
            title: Text("Delete"),
            onTap: onDelete,
          )
      ),

    ],
    offset: Offset(0, 100),
    color: Colors.grey,
    elevation: 2,
  ),

);
}



