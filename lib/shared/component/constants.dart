import 'dart:ui';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/favorite/favorite_model.dart';
import 'package:shop_app/models/products/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/Home/Address/cubit/cubit.dart';

List<Color> colors = [
  Color(0xff6CD5C6),
  Color(0xffFDA88B),
  Color(0xff9BBFF4),
  Color(0xffF69FD6),
  Color(0xffBCA1F2),
  Color(0xff8EC6D3)
];
List<Color> item_colors = [
  Color(0xff25BBA6),
  Color(0xffE46940),
  Color(0xff3F7FE7),
  Color(0xffE750B1),
  Color(0xff7C49E4),
  Color(0xff26A8C0)
];
String Token;

HomeModel homeModel;
CategoryModel category_model;
FavoriteModel favoriteModel;
LoginModel model ;
bool x=false;
int widgett=0;
Color defaultcolor=Color(0xff6CB9E7);

bool xx=true;

final navigatorKey = GlobalKey<NavigatorState>();