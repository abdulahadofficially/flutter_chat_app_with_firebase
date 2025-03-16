import 'package:flutter_chat_app_with_firebase/controllers/chat_controller.dart';
import 'package:get/get.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}
