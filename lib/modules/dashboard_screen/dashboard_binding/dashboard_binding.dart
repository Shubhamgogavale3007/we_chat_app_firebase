import 'package:get/get.dart';
import 'package:we_chat_app/modules/dashboard_screen/dashboard_controller/dashboard_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DashboardController>(
          () => DashboardController(),
    );
  }

}