import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final refs = FirebaseDatabase.instance.ref('User');
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

void setUserName(String username) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('userName', username);
  print('getUsername----> '+sharedPreferences.getString("userName").toString());
}

  void setUserId(String userid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('userId', userid);
    print('getUserid----> '+sharedPreferences.getString("userId").toString());
  }

}
