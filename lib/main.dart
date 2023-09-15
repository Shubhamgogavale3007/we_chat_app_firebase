import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat_app/app_routes.dart';
import 'package:we_chat_app/dialog/navigator_key.dart';
import 'app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseNotificationBackgroundHandler);
  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseNotificationBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorKey.navigatorKey,
      title: 'Flutter Demo',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
