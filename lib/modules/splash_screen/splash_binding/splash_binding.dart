import 'package:get/get.dart';
import 'package:we_chat_app/modules/splash_screen/splash_controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
