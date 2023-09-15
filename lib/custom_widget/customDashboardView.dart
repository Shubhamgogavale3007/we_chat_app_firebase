import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_routes.dart';
import '../modules/dashboard_screen/dashboard_controller/dashboard_controller.dart';

class CustomDashboardView extends StatelessWidget {
  CustomDashboardView({
    super.key,
    required this.controller,
    required this.index,
    required this.list,
  });

  List<dynamic> list;
  int index;
  DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible:
          list[index]['id'] == controller.auth.currentUser!.uid ? false : true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.deepPurple),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: list[index]['image'],
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    list[index]['username'],
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            print('---->${list[index]['username']}');
            Get.toNamed(AppRoutes.chat, arguments: [
              list[index]['image'],
              list[index]['username'],
              list[index]['id'],
            ]);
          },
        ),
      ),
    );
  }
}
