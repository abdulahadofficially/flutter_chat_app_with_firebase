import 'package:flutter/material.dart';
import 'package:flutter_chat_app_with_firebase/controllers/chat_controller.dart';
import 'package:flutter_chat_app_with_firebase/helpers/firebase_helper.dart';
import 'package:flutter_chat_app_with_firebase/models/message_model.dart';
import 'package:flutter_chat_app_with_firebase/models/user_model.dart';
import 'package:flutter_chat_app_with_firebase/utils/app_loader.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../../models/chat_model.dart';

class ChatPage extends GetView<ChatController> {
  final UserModel userModel;

  ChatPage({super.key}) : userModel = Get.arguments as UserModel;

  @override
  Widget build(BuildContext context) {
    final currentUser = ChatUser(
      id: '${FirebaseHelper.getUserId()}',
      firstName: FirebaseHelper.getUserId()?.displayName,
    );
    final otherUser = ChatUser(id: userModel.id, firstName: userModel.userName);

    return Scaffold(
      appBar: AppBar(
        title: Text('${userModel.userName.capitalizeFirst}'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      body: StreamBuilder<ChatModel?>(
        stream: controller.chatService.getChat(
          userId1: FirebaseHelper.getUserId()?.uid ?? '',
          userId2: userModel.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: AppLoader.showLoading(color: Colors.white));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No messages yet'));
          }

          final chatList = snapshot.data!;
          List<ChatMessage> chatMessages = convertChatMessages(
            message: chatList.messages,
            currentUser: currentUser,
            otherUser: otherUser,
          );

          return DashChat(
            messageListOptions: const MessageListOptions(
              separatorFrequency: SeparatorFrequency.days,
              showDateSeparator: true,
            ),
            messageOptions: MessageOptions(
              showTime: true,
              showOtherUsersAvatar: false,
              messageDecorationBuilder:
                  (message, previousMessage, nextMessage) {
                bool isCurrentUser = message.user.id == currentUser.id;
                return BoxDecoration(
                  color: isCurrentUser
                      ? const Color(0xFF008069)
                      : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: isCurrentUser
                        ? const Radius.circular(15)
                        : const Radius.circular(2),
                    bottomRight: isCurrentUser
                        ? const Radius.circular(2)
                        : const Radius.circular(15),
                  ),
                );
              },
            ),
            currentUser: currentUser,
            onSend: (message) {
              controller.sendChat(
                message,
                FirebaseHelper.getUserId()?.uid ?? '',
                userModel.id,
              );
            },
            messages: chatMessages,
            inputOptions: InputOptions(
              
              alwaysShowSend: true,
              inputDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type message here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              inputTextStyle: const TextStyle(color: Colors.black),
            ),
          );
        },
      ),
    );
  }

  List<ChatMessage> convertChatMessages({
    required List<MessageModel> message,
    required ChatUser currentUser,
    required ChatUser otherUser,
  }) {
    List<ChatMessage> chatMessages = message
        .map(
          (message) => ChatMessage(
            user: message.senderId == '${FirebaseHelper.getUserId()?.uid}'
                ? currentUser
                : otherUser,
            createdAt: message.sentAt,
            text: message.message,
          ),
        )
        .toList();
    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return chatMessages;
  }
}
