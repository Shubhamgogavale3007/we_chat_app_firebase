import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  void toastMessage(String e){
Fluttertoast.showToast(   msg: e,
  backgroundColor: Colors.red,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  textColor: Colors.white,
  fontSize: 16.0);
}
}