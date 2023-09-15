
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../utils/utils_class.dart';
import '../../login_screen/login_view/login_view.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController image = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('User');
  final auth = FirebaseAuth.instance;

  void RegisterValidation() {
    if (username.text.isEmpty) {
      Utils().toastMessage('Please Enter Username');
    } else if (emailController.text.isEmpty) {
      Utils().toastMessage('Please Enter Email');
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      Utils().toastMessage('Invalid Email');
    } else if (passwordController.text.isEmpty) {
      Utils().toastMessage('Please Enter Password');
    } else {
      auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        /// FOR FIRESTORE
        /*final firestore = FirebaseFirestore.instance.collection('Users');
        firestore.add({
          'username': username.text,
          'image':
          'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1060&t=st=1693314174~exp=1693314774~hmac=bb2af83c91553594a75fe57df7bc63ea1a3f2f11bd31b36b0789db6ec233f90a',
          'id': value.user!.uid.toString(),
        });*/
        /// FOR FIREBASE
        databaseRef.push().set({
          'username': username.text,
          'image': /*image.text*/
              'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=1060&t=st=1693314174~exp=1693314774~hmac=bb2af83c91553594a75fe57df7bc63ea1a3f2f11bd31b36b0789db6ec233f90a',
          'id': value.user!.uid.toString(),
        });
        Get.to(LoginScreen());
        Utils().toastMessage('Registered Successfully');
        emailController.clear();
        username.clear();
        passwordController.clear();
      }).onError((error, stackTrace) {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          Get.showSnackbar(GetSnackBar(
            duration: const Duration(seconds: 3),
            title: 'Weak password!',
            message: '$error',
          ));
        }
      });
    }
  }
}
