import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_routes.dart';
import '../dashboard_controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: const Text('We Chat'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: const Icon(Icons.login),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Get.back();
                });
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: controller.refs.onValue,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.snapshot.value != null) {
                          List<dynamic> list = [];

                          final myItems = snapshot.data!.snapshot.children;
                          for (var i in myItems) {
                            final nextItem =
                                Map<String, dynamic>.from(i.value as Map);
                            list.add(nextItem);
                          }

                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index){
                                if (list[index]['id'] == controller.auth.currentUser!.uid) {
                                  controller.setUserName(list[index]['username']);
                                }
                                if (list[index]['id'] == controller.auth.currentUser!.uid) {
                                  controller.setUserId(list[index]['id']);
                                }

                                return Visibility(
                                  visible: list[index]['id'] ==
                                          controller.auth.currentUser!.uid
                                      ? false
                                      : true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: GestureDetector(
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.deepPurple),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: list[index]['image'],
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                list[index]['username'],
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        print(
                                            '---->${list[index]['username']}');
                                        Get.toNamed(AppRoutes.chat, arguments: [
                                          list[index]['image'],
                                          list[index]['username'],
                                          list[index]['id'],
                                        ]);
                                      },
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(child: Text('No Data Found'));
                        }
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
