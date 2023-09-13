import 'dart:io';
import 'dart:math';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else {
      AppSettings.openAppSettingsPanel(AppSettingsPanelType.nfc);
      print('user denied permission');
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotification(message);
        showNotification(message);
      }
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void initLocalNotification(RemoteMessage message) async {
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initialisationSetting =
        InitializationSettings(android: androidInitializationSettings);
    await notificationsPlugin.initialize(initialisationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  Future<void> showNotification(RemoteMessage message) async {
    print('+++Show Notification');

    ///
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Important Notification',
        importance: Importance.max);

    ///
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails details =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      notificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), details);
    });
  }
}
