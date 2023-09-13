import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:we_chat_app/notification_service.dart';
import 'package:we_chat_app/utils/utils_class.dart';
import '../../../app_routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    NotificationService().firebaseInit();

    NotificationService().requestNotificationPermission();
    NotificationService().getDeviceToken().then((value) {
      print('Device Token : ${value}');
    });
  }

  void LoginValidation() {
    if (emailController.text.isEmpty) {
      Utils().toastMessage('Please Enter Email');
    } else if (passwordController.text.isEmpty) {
      Utils().toastMessage('Please Enter Password');
    }
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      print('----->${value}');
      Get.toNamed(AppRoutes.dashboard);
      Utils().toastMessage('Logged In Successfully');
    }).onError((error, stackTrace) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        Get.showSnackbar(GetSnackBar(
          duration: Duration(seconds: 1),
          message: '$error',
        ));
      }
    });
  }
}
