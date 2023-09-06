import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: '3e1b094eb3674f11b37d68b1deb1d3ea',
      channelName: 'shubham',
      tempToken: '007eJxTYDBTj/LdOPHFlisf7P8b2X1/Y9wXe+vNTbZZHBarrW8uSVijwGCcaphkYGmSmmRsZm6SZmiYZGyeYmaRZJiSCsTGqYnlBt9TGgIZGbhzWlkYGSAQxGdnKM4oTcpIzGVgAAA5lSIy',
    ),
  );


  Future<void> _initializeAgora() async {
    await _client.initialize();
  }

  @override
  void initState() {
    _initializeAgora();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(client: _client)
            ],
          ),
        ),
      ),
    );
  }
}