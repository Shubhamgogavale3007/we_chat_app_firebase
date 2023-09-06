import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_routes.dart';
import '../dashboard_controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: Text('We Chat'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: Icon(Icons.login),
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
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: controller.refs.onValue,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data!.snapshot.value != null) {
/// Proper Way
                          List<dynamic> list = [];

                          final myItems = snapshot.data!.snapshot.children;
                          for (var i in myItems) {
                            final nextItem = Map<String, dynamic>.from(i.value as Map);
                            list.add(
                                nextItem
                            );
                          }
                          /// Not Proper Way
                    /*      Map<dynamic, dynamic> map =
                              snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> list = [];
                          list = map.values.toList();*/
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final auth = FirebaseAuth.instance;

                                return Visibility(
                                  visible:
                                      list[index]['id'] == auth.currentUser!.uid
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
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                list[index]['username'],
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                              });
                        } else {
                          return Center(child: Text('No Data Found'));
                        }
                      } else {
                        return Center(
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
