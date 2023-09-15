import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreen();
}

class _VideoCallScreen extends State<VideoCallScreen> {
  final navigatorKey = GlobalKey<NavigatorState>();

  late String id;
  late String name;
  late String userid;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments[0];
    name = Get.arguments[1];
    userid = Get.arguments[2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
        appID: 691913683,
        appSign:
            '5fc09d3f316ce676414ced60028cdf80dc4172a21cd829a6897dd8692df434cc',
        callID: id,
        userID: userid,
        userName: name,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onOnlySelfInRoom = (context) {
            Navigator.pop(context);
          },
      ),
    );
  }
}
