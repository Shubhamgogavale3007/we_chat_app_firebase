import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';


class PreviewImage extends StatefulWidget {
  const PreviewImage(this.path,{super.key});

  final String path;

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  final controller = Get.find<ChatController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    child: Icon(Icons.cancel_outlined),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.emoji_emotions_sharp),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.crop),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.text_fields_rounded),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.edit_outlined),
                ],
              ),
              Container(
                height: 600,
                child: Image.file(
                  File(widget.path),
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                scrollPadding: EdgeInsets.only(bottom: 40),

                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.image,
                    color: Colors.grey,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Icon(Icons.send, color: Colors.grey),
                          onTap: () {
                            addChat();
                          Navigator.pop(context);

                          },
                        ),
                      ],
                    ),
                  ),
                  focusedBorder:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Add a caption ...',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final databaseRef = FirebaseDatabase.instance.ref('Chats');
  void addChat() {
    databaseRef.child('${controller.chatId}').push().set({
      'chats': controller.chat.text,
      'Sender':controller.currentId,
      'Reciever': controller.id,
      'time': controller.formattedTime,
      'camera': controller.selectedImagePath == '' ? 'empty' : controller.selectedImagePath,
      'gallery': controller.selectedGalleryImagePath == ''
          ? 'emptyGallery'
          : controller.selectedGalleryImagePath,
      'latitude': controller.latitude == '' ? 'empty' : controller.latitude,
      'longitude': controller.longitude == '' ? 'empty' :  controller.longitude
    });
    controller.chat.clear();
    controller.selectedImagePath = '';
    controller.selectedGalleryImagePath = '';
    controller.latitude = '';
    controller.longitude = '';
  }

}
