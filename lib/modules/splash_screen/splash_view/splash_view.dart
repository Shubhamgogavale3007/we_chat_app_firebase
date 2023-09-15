import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:we_chat_app/app_routes.dart';

import 'package:we_chat_app/modules/splash_screen/splash_controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () => Get.toNamed(AppRoutes.login));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_new.png',height: 70,width: 70,),
             
                Text('We Chat App',style: GoogleFonts.spaceGrotesk(fontSize: 25)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
