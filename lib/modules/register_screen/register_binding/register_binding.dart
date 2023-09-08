import 'package:get/get.dart';
import 'package:we_chat_app/modules/register_screen/register_controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RegisterController());
  }
}
