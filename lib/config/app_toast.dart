import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oqu_way/config/app_colors.dart';

class AppToast{
  static void showToast(String toastText){
    Fluttertoast.showToast(
        msg: toastText,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: AppColors.blueColor,
        fontSize: 16.0
    );
  }
}