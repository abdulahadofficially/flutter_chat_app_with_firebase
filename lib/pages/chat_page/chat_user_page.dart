import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/controllers/auth_controllers.dart';
import 'package:flutter_chat_app_with_firebase/controllers/chat_controller.dart';
import 'package:flutter_chat_app_with_firebase/helpers/firebase_helper.dart';
import 'package:flutter_chat_app_with_firebase/models/user_model.dart';
import 'package:flutter_chat_app_with_firebase/routes.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_loader.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_toast.dart';
import 'package:get/get.dart';

class ChatUserPage extends GetView<ChatController> {
  const ChatUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
        actions: [
          TextButton.icon(
              onPressed: () => authController.logoutUser(),
              label: authController.isLoading.value
                  ? AppLoader.showLoading()
                  : const Text('Logout', style: TextStyle(color: Colors.blue)))
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: controller.userService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoader.showLoading(color: Colors.white);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              "No users found",
              style: TextStyle(color: Colors.white),
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                    title: Text(
                      '${user.userName.capitalizeFirst}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      user.email,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Center(
                          child: Text(
                        '${user.userName[0].capitalizeFirst}',
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.blueAccent),
                    onTap: () async {
                      final isChatExsit = await controller.chatService
                          .getChatReference(
                              userId1: '${FirebaseHelper.getUserId()?.uid}',
                              userId2: user.id);
                      if (isChatExsit == null) {
                        controller.createChat(userProfileId: user.id);
                      }
                      Get.toNamed(AppRoutes.chatPage, arguments: user);
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
