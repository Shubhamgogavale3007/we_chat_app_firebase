import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:we_chat_app/modules/chat_screen/chat_binding/chat_binding.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';
import 'package:we_chat_app/modules/chat_screen/chat_view/chat_view.dart';
import 'package:we_chat_app/modules/dashboard_screen/dashboard_binding/dashboard_binding.dart';
import 'package:we_chat_app/modules/dashboard_screen/dashboard_view/dashboard_view.dart';
import 'package:we_chat_app/modules/login_screen/login_binding/login_binding.dart';
import 'package:we_chat_app/modules/login_screen/login_view/login_view.dart';
import 'package:we_chat_app/modules/register_screen/register_binding/register_binding.dart';
import 'package:we_chat_app/modules/register_screen/register_view/register_view.dart';
import 'package:we_chat_app/modules/splash_screen/splash_binding/splash_binding.dart';
import 'package:we_chat_app/modules/splash_screen/splash_view/splash_view.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),

  ];
}