



import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:we_chat_app/app_routes.dart';
import 'package:we_chat_app/modules/register_screen/register_view/register_view.dart';


import 'package:we_chat_app/modules/splash_screen/splash_controller/splash_controller.dart';

import '../../login_screen/login_view/login_view.dart';




class SplashScreen extends GetView<SplashController>{
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),()=>Get.toNamed(AppRoutes.login
    )
    );

 return Scaffold(
   body: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [

       Image.asset('assets/images/logo.png'),
     ],
   ),
 );
  }

}