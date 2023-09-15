import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../preview_screen/preview_screen.dart';

class ChatController extends GetxController {
  GoogleMapController? mapController;
  final databaseRef = FirebaseDatabase.instance.ref('Chats');
  final firestore = FirebaseFirestore.instance.collection('Users Chats');
  final auth = FirebaseAuth.instance;
  TextEditingController chat = TextEditingController();
  String image = '';
  String userName = '';
  String id = '';
  String latitude = '';
  String longitude = '';
  String selectedImagePath = '';
  String selectedGalleryImagePath = '';
  RxString setWallpaperBackground = ''.obs;
  String currentId = '';
  RxString chatId = ''.obs;
  late String usernamecall;
  late String useridcall;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    image = Get.arguments[0];
    userName = Get.arguments[1];
    id = Get.arguments[2];
    currentId = auth.currentUser!.uid;
    checkChatId();
    getUserName();
    getUserId();
    checkWallpaper();
  }

  /// DELETE CHATS
  void deleteAllChats() {
    databaseRef.child(chatId.value).remove();
  }

  void getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    usernamecall = sp.getString('userName')!;
    print('------>$usernamecall');
  }

  void getUserId() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    useridcall = sp.getString('userId')!;
    print('------>$useridcall');
  }

  /// SELECT IMAGE FROM CAMERA
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      /*   selectedImagePath = file.path;
      addChatToFirebase();*/
      Get.to(PreviewImage(file.path), arguments: ["camera"]);
      /* return file.path;*/
    } else {
      return '';
    }
  }

  /// SELECT IMAGE FROM GALLERY

  addImagesStorageGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      /// RIGHT WAY
      Get.to(PreviewImage(image.path), arguments: ["gallery"]);

      /// WRONG WAY
/*      _photo = File(image.path.toString());
      final uploadTask = ref.child(_photo.path).putFile(_photo);
      final taskSnapshot = await uploadTask.snapshot.ref.getDownloadURL();
      selectedGalleryImagePath = await taskSnapshot.toString();*/
    } else {
      return '';
    }
  }

  /// Set Wallpaper
  setWallpaper() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (image != null) {
      setWallpaperBackground.value = image.path;
      sp.setString('wallpaper', setWallpaperBackground.toString());
      print('setWallpaperBackground----> ' +
          sp.getString("wallpaper").toString());
    } else {
      return '';
    }
  }

  /// CHECK WALLPAPER IS SET OR NOT
  Future<void> checkWallpaper() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString("wallpaper").toString() != null) {
      setWallpaperBackground.value = sp.getString("wallpaper").toString();
    }
  }

  /// GET DATA FROM FIREBASE
  DatabaseReference fetchFirebaseData() {
    return FirebaseDatabase.instance.ref('Chats').child(chatId.value);
  }

  void checkChatId() {
    databaseRef.child('$id+__+${auth.currentUser!.uid}').get().then((value) {
      if (value.exists) {
        chatId.value = '$id+__+${auth.currentUser!.uid}';
      } else {
        databaseRef
            .child('${auth.currentUser!.uid}+__+$id')
            .get()
            .then((value) {
          if (value.exists) {
            chatId.value = '${auth.currentUser!.uid}+__+$id';
          } else {
            chatId.value = '${auth.currentUser!.uid}+__+$id';
          }
        });
      }
    });

    refresh();
  }

  /// ADD CHAT TO FIREBASE
  void addChatToFirebase() {
    databaseRef.child('$chatId').push().set({
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

/*  /// SELECT IMAGE FROM GALLERY
  selectImageFromGallery() async {
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
  }*/

  /// FOR FIRESTORE

  void addChatToFirestore() {
    firestore
        .doc('${chatId}')
        .collection('chats')
        .add({
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
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
