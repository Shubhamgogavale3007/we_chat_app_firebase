import 'package:get/get.dart';
import 'package:we_chat_app/modules/chat_screen/chat_controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
