import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../preview_screen/preview_screen.dart';

class ChatController extends GetxController {
  TextEditingController chat = TextEditingController();
  String image = '';
  String userName = '';
  String id = '';
  String latitude = '';
  String longitude = '';
  String selectedImagePath = '';
  String selectedGalleryImagePath = '';
  String currentId = '';
  RxString chatId = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    image = Get.arguments[0];
    userName = Get.arguments[1];
    id = Get.arguments[2];
    currentId = auth.currentUser!.uid;
    checkChatId();

    print(currentId);
  }

  /// SELECT IMAGE FROM GALLERY
  selectImageFromCamera() async {
    print('========>>>');
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      selectedImagePath = file.path;
      print('=====${selectedImagePath}');
      Get.to(
        PreviewImage(file.path),
      );
      /* return file.path;*/
    } else {
      return '';
    }
  }

  /// SELECT IMAGE FROM CAMERA
  selectImageFromGallery() async {
    print('========>>>');
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      selectedImagePath = image.path;
      Get.to(
        PreviewImage(image.path),
      );
    } else {
      return '';
    }
  }

  /// GET DATA FROM FIREBASE
  DatabaseReference fetchFirebaseData() {
    return FirebaseDatabase.instance.ref('Chats').child(chatId.value);
  }

  final databaseRef = FirebaseDatabase.instance.ref('Chats');
  final auth = FirebaseAuth.instance;

  void checkChatId() {
    databaseRef.child('${id}+__+${auth.currentUser!.uid}').get().then((value) {
      if (value.exists) {
        chatId.value = '${id}+__+${auth.currentUser!.uid}';
      } else {
        print("--->false");
        databaseRef
            .child('${auth.currentUser!.uid}+__+${id}')
            .get()
            .then((value) {
          if (value.exists) {
            chatId.value = '${auth.currentUser!.uid}+__+${id}';
          } else {
            print("--->false first tiem");
            chatId.value = '${auth.currentUser!.uid}+__+${id}';
          }
        });
      }
    });

    refresh();
  }

  /// ADD CHAT TO FIREBASE
  void addChatToFirebase() {
    databaseRef.child('${chatId}').push().set({
      'chats': chat.text,
      'Sender': currentId,
      'Reciever': id,
      'time': formattedTime,
      'camera': selectedImagePath == '' ? 'empty' : selectedImagePath,
      'gallery': selectedGalleryImagePath == ''
          ? 'emptyGallery'
          : selectedGalleryImagePath,
      'latitude': latitude == '' ? 'empty' : latitude,
      'longitude': longitude == '' ? 'empty' : longitude
    });
    chat.clear();
    selectedImagePath = '';
    selectedGalleryImagePath = '';
    latitude = '';
    longitude = '';
  }

  String formattedTime = DateFormat('kk:mm aa').format(DateTime.now());
}
