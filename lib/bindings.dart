import 'package:chat_bridge/services/getx_controller/main_controller.dart';
import 'package:get/get.dart';

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatBridgeMainController());
  }
}
