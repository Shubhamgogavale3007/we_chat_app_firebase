import 'package:flutter/material.dart';
import 'package:we_chat_app/dialog/navigator_key.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';

alertDialog(String msg) {
  //Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  //Toast.show(msg, duration: Toast.lengthShort, gravity: Toast.bottom);
  print('msg--$msg');
  print(
      'NavigatorKey.navigatorKey.currentContext--${NavigatorKey.navigatorKey.currentContext}');
  showAlertDialog(NavigatorKey.navigatorKey.currentContext!, msg);
}

showAlertDialog(BuildContext context, String msg) {
  // set up the button
  Widget okCancel = TextButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.deepPurple),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget deleteChat = TextButton(
    child: Text(
      "Delete Chat",
      style: TextStyle(color: Colors.deepPurple),
    ),
    onPressed: () {
      ChatController().deleteAllChats();
      // onLogout();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete this chat?",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
    content: Text(msg),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    actions: [
      okCancel,
      deleteChat,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}