import 'package:emartseller/const/files.dart';
import 'package:flutter/material.dart';
const navbarIcon = [dashboardlogo,shoplogo,orderlogo,shoplogo];
const navbarTitle = ["Dashboard","Products","order","profile"];
var navbarItems= [
  BottomNavigationBarItem(icon: Icon(Icons.dashboard,),label: dashboard),
  BottomNavigationBarItem(icon:Icon(CupertinoIcons.cube_box_fill),label: products),
  BottomNavigationBarItem(icon: Icon(CupertinoIcons.cube_box),label: order),
  BottomNavigationBarItem(icon:Icon(Icons.person),label: profile),
];

var insightTitle = ["Products","Rating","Total \n Orders","Total \n selles"];
var insightIcon = [shoplogo,starlogo,orderlogo,dollarlogo];
var insightValue = ["50","05","2K","1K"];

var Screen = [
  HomeScreen(),
  ProductListScreen(),
  OrderScreen(),
  ProfileScreen(),
];

var profileTitles = [
  "Change Password","Shop Setting","chat"
];
var profileIcons = [
  Icon(Icons.key),
  Icon(Icons.settings),
  Icon(Icons.chat)


];

var ProfileScreens = [
  ChangePassword(),
  ShopSetting(),
  ChatScreen()
];
List<String> category = ["Women Dress","Men Clotings & Fashion","Computer & Accessories","Automobile","Kids & Toys","Sports","Jewelley","Furniture","Cellphone & Tab"];
List<String> WomenDress = [
  "Wedding & Event",
  "Tops & sets"
];
List<String> MenClothing = [
  "Outwear & Jackets",
  "Formal Dress",
  "Accessories"
];
List<String> Computer = [
  "Laptop",
  "Gaming PC",
  "Offical Equipment"
];
List<String>  Automobile = [
  "Cars",
  "Bikes"
];
List<String> Kids = [
  "Shoes & Bags",
  "Baby Clothing",
  "Girls Toys"
];
List<String> Sports = [
  "Footballs",
  "Bat",
  "jolf"
];
List<String> Jewelley = [
  "Necklace",
  "Gold",
  "Earing"
];
List<String> Furniture = [
  "Bed",
  "Sofa"
];
List<String> Cellphone = [
  "Android Mobiles",
  "Tabs",
  "Iphones",
  "Watches"
];
