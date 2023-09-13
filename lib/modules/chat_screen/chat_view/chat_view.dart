import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:we_chat_app/dialog/alert_dialog.dart';
import 'package:we_chat_app/dialog/dialog_screen.dart';
import 'package:we_chat_app/maps_screen/maps_screen.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';

import '../../../video_call_screen.dart';
import '../../../voice_call_screen.dart';

class ChatScreen extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    GoogleMapController? mapController;
    final controller = Get.find<ChatController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(controller.image),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(controller.userName),
          ],
        ),
        actions: [
          Row(
            children: [
              InkWell(
                child: const Icon(Icons.call),
                onTap: () {
                  Get.to(VoiceCallScreen(), arguments: [
                    controller.chatId.toString(),
                    controller.usernamecall,
                    controller.useridcall,
                  ]);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                child: const Icon(Icons.videocam_sharp),
                onTap: () {
                  Get.to(VideoCallScreen(), arguments: [
                    controller.chatId.toString(),
                    controller.usernamecall,
                    controller.useridcall,
                  ]);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: () {
                      controller.setWallpaper();
                      print('------>${controller.setWallpaperBackground}');
                    },
                    value: 1,
                    child: Text("Change Background Wallpaper"),
                  ),
                  PopupMenuItem(value: 2, child: Text("Search")),
                  PopupMenuItem(
                      onTap: () {
                        alertDialog('This messages will not be recovered')
                            .then((value) {
                          Get.back();
                        });
                      },
                      value: 3,
                      child: Text("Delete All Chats")),
                  PopupMenuItem(
                      value: 4,
                      // row has two child icon and text
                      child: Text("About")),
                ],
                offset: Offset(0, 50),
                color: Colors.white,
                elevation: 5,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(
                      File(controller.setWallpaperBackground.value.toString())),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(() => Stack(
                  children: [
                    controller.chatId.isEmpty
                        ? Container()
                        : StreamBuilder(
                            stream: controller.fetchFirebaseData().onValue,
                            builder: (context,
                                AsyncSnapshot<DatabaseEvent> snapshot) {
                              if (snapshot.data != null) {
                                if (snapshot.data!.snapshot.value != null) {
                                  List<dynamic> chatList = [];

                                  final myItems =
                                      snapshot.data!.snapshot.children;

                                  for (var i in myItems) {
                                    final nextItem = Map<String, dynamic>.from(
                                        i.value as Map);
                                    chatList.add(nextItem);
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 50),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: chatList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            child: Align(
                                              alignment: chatList[index]
                                                          ['Sender'] ==
                                                      controller.currentId
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: chatList[
                                                                      index]
                                                                  ['Sender'] ==
                                                              controller
                                                                  .currentId
                                                          ? CrossAxisAlignment
                                                              .end
                                                          : CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical: 3),
                                                          child: Text(
                                                            chatList[index]
                                                                    ['chats'] ??
                                                                '',
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: chatList[
                                                                          index]
                                                                      [
                                                                      'camera'] ==
                                                                  'empty'
                                                              ? false
                                                              : true,
                                                          child: Image.file(
                                                            File(chatList[index]
                                                                    ['camera']
                                                                .toString()),
                                                            height: 200,
                                                            width: 200,
                                                          ),
                                                        ),
                                                        Visibility(
                                                            visible: chatList[
                                                                            index]
                                                                        [
                                                                        'gallery'] ==
                                                                    'emptyGallery'
                                                                ? false
                                                                : true,
                                                            child:
                                                                Image.network(
                                                              chatList[index]
                                                                  ['gallery'].toString(),
                                                              height: 200,
                                                              width: 200,
                                                            )),
                                                        chatList[index][
                                                                    'latitude'] ==
                                                                'empty'
                                                            ? Container()
                                                            : Container(
                                                                height: 200,
                                                                width: 200,
                                                                child:
                                                                    GoogleMap(
                                                                  mapType: MapType
                                                                      .normal,
                                                                  zoomControlsEnabled:
                                                                      false,
                                                                  markers: {
                                                                    Marker(
                                                                      markerId:
                                                                          const MarkerId(
                                                                              'marker_id_1'),
                                                                      position: LatLng(
                                                                          double.parse(chatList[index]
                                                                              [
                                                                              'latitude']),
                                                                          double.parse(chatList[index]
                                                                              [
                                                                              'longitude'])),
                                                                    )
                                                                  },
                                                                  initialCameraPosition:
                                                                      CameraPosition(
                                                                    target: LatLng(
                                                                        double.parse(chatList[index]
                                                                            [
                                                                            'latitude']),
                                                                        double.parse(chatList[index]
                                                                            [
                                                                            'longitude'])),
                                                                    zoom:
                                                                        17.4746,
                                                                  ),
                                                                  onMapCreated:
                                                                      (GoogleMapController
                                                                          controller) {
                                                                    mapController =
                                                                        controller;
                                                                  },
                                                                ),
                                                              ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 3),
                                                          child: Text(
                                                            chatList[index]
                                                                ['time'],
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        11),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                } else {
                                  return const Center(
                                      child: Text(
                                    'No Data Found',
                                    style: TextStyle(color: Colors.white),
                                  ));
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                              }
                            }),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextField(
                        scrollPadding: const EdgeInsets.only(bottom: 40),
                        controller: controller.chat,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        //Normal textInputField will be displayed
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.emoji_emotions_sharp,
                            color: Colors.grey,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  child: const Icon(Icons.send,
                                      color: Colors.grey),
                                  onTap: () {
                                    controller.addChatToFirebase();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: const Icon(Icons.attach_file,
                                      color: Colors.grey),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const PopUp();
                                        }).then((value) async {
                                      if (value == "camera") {
                                        controller.selectImageFromCamera();
                                      } else if (value == "gallery") {
                                        controller.addImagesStorageGallery();
                                      } else if (value == "location") {
                                        Get.to(() => const MapsScreen())!
                                            .then((value) {
                                          controller.latitude = value['lat'];
                                          controller.longitude = value['lng'];

                                          controller.addChatToFirebase();
                                          print('========${value['lat']}');
                                        });
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(Icons.camera_alt,
                                    color: Colors.grey),
                              ],
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Type here',
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
