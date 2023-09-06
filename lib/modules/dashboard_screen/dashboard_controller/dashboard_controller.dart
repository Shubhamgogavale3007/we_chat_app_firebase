import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  final refs = FirebaseDatabase.instance.ref('User');


}