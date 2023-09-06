import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:we_chat_app/app_routes.dart';
import 'package:we_chat_app/modules/login_screen/login_controller/login_controller.dart';
import 'package:we_chat_app/modules/register_screen/register_view/register_view.dart';

class LoginScreen extends GetView<LoginController>{

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 0,
            ),
            const Text(
              'Login Here',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color:  Colors.deepPurple),
            ),
            const SizedBox(
              height: 80,
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter E-mail',hintStyle: TextStyle(
                color:  Colors.deepPurple
              )),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter Password',hintStyle: TextStyle(
                  color:  Colors.deepPurple
              )),
            ),
            const SizedBox(
              height: 30,
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
                    controller.LoginValidation();

                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dont have account?',
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF535353)),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color:  Colors.deepPurple),
                  ),
                  onTap: (){
                    Get.toNamed(AppRoutes.register);
                  },
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

}