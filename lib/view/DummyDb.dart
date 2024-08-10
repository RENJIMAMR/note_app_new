import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app_new/utils/app_sessions.dart';
import 'package:note_app_new/utils/color_constants.dart';

class Dummydb {
  static bool? isLock = false;
  static String? password;
// var passwordBox = Hive.box(AppSessions.PASSWORD);
//   List passKeys = [];

  static List<Map> ListCardData = [
    // {
    //   'title': '',
    //   "content": '',
    //   'date': '',
    // },
    // {
    //   'title': 'to do ',
    //   "content": 'hostel arrangement and setting',
    //   'date': 'Tue,Feb 23,2024',
    // },
    // {
    //   'title': 'to buy',
    //   "content": 'groceries for kitchen',
    //   'date': 'Tue,Feb 22,2024'
    // }
  ];
  static List<Color> colorsList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4,
    ColorConstants.clr5,
  ];
}
