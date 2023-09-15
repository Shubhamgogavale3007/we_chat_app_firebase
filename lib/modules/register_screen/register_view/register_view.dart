import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat_app/custom_widget/custom_textfeild.dart';
import 'package:we_chat_app/modules/register_screen/register_controller/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create a new Account'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CustomTextFeild(
                controller: controller.username,
                hintText: 'Enter Username',
                color: Colors.deepPurple),
        /*    TextField(
              controller: controller.username,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Username',
                  hintStyle: TextStyle(color: Colors.deepPurple)),
            ),*/
            const SizedBox(
              height: 30,
            ),
            CustomTextFeild(
                controller: controller.emailController,
                hintText: 'Enter E-mail',
                color: Colors.deepPurple),
         /*   TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  hintText: 'Enter E-mail',
                  hintStyle: TextStyle(color: Colors.deepPurple)),
            ),*/
            const SizedBox(
              height: 30,
            ),
            CustomTextFeild(
                controller: controller.passwordController,
                hintText: 'Enter Password',
                color: Colors.deepPurple),
          /*  TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.deepPurple)),
            ),*/
            const SizedBox(
              height: 30,
            ),
            CustomTextFeild(
                controller: controller.image,
                hintText: 'Enter Image URL......',
                color: Colors.deepPurple),
         /*   TextField(
              controller: controller.image,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Image URL....',
                  hintStyle: TextStyle(color: Colors.deepPurple)),
            ),*/
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    controller.RegisterValidation();
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
