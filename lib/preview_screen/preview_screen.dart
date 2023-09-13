import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';

class PreviewImage extends StatefulWidget {
  PreviewImage(this.path, {super.key});

  final String path;

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  final controller = Get.find<ChatController>();
  bool isLoading = false;
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
                    child: const Icon(Icons.cancel_outlined),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.emoji_emotions_sharp),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.crop),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.text_fields_rounded),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.edit_outlined),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 600,
                    child: Image.file(
                      File(widget.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Visibility(
                    visible: isLoading ? true : false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                scrollPadding: const EdgeInsets.only(bottom: 40),

                keyboardType: TextInputType.multiline,
                minLines: 1, //Normal textInputField will be displayed
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
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
                          child: const Icon(Icons.send, color: Colors.grey),
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            Reference ref =
                                FirebaseStorage.instance.ref('Images');
                            late File _photo;
                            _photo = File(widget.path.toString());
                            String fileName = _photo.path.split('/').last;
                            final TaskSnapshot snapshot = await ref
                                .child(basename(fileName))
                                .putFile(_photo);
                            controller.selectedGalleryImagePath =
                                await snapshot.ref.getDownloadURL();
                            print(
                                '----->>>>${controller.selectedGalleryImagePath}');
                            addChat(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
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
  void addChat(BuildContext context) {
    databaseRef.child('${controller.chatId}').push().set({
      'chats': controller.chat.text,
      'Sender': controller.currentId,
      'Reciever': controller.id,
      'time': controller.formattedTime,
      'camera': controller.selectedImagePath == ''
          ? 'empty'
          : controller.selectedImagePath,
      'gallery': controller.selectedGalleryImagePath == ''
          ? 'emptyGallery'
          : controller.selectedGalleryImagePath,
      'latitude': controller.latitude == '' ? 'empty' : controller.latitude,
      'longitude': controller.longitude == '' ? 'empty' : controller.longitude
    });
    setState(() {
      isLoading = false;
      Navigator.pop(context);
    });
    controller.chat.clear();
    controller.selectedImagePath = '';
    controller.selectedGalleryImagePath = '';
    controller.latitude = '';
    controller.longitude = '';
  }
}
