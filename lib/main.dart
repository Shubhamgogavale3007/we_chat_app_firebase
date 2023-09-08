import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat_app/app_routes.dart';
import 'package:we_chat_app/dialog/navigator_key.dart';

import 'app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKey.navigatorKey,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}
