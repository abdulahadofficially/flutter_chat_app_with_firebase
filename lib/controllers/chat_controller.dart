import 'dart:developer';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_chat_app_with_firebase/constants/firebase_collection.dart';
import 'package:flutter_chat_app_with_firebase/helpers/firebase_helper.dart';
import 'package:flutter_chat_app_with_firebase/models/chat_model.dart';
import 'package:flutter_chat_app_with_firebase/models/message_model.dart';
import 'package:flutter_chat_app_with_firebase/services/chat_services.dart';
import 'package:flutter_chat_app_with_firebase/services/user_service.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final UserService _userService = UserService();
  final ChatServices _chatService = ChatServices();

  UserService get userService => _userService;

  ChatServices get chatService => _chatService;

  Future<void> createChat({required String userProfileId}) async {
    try {
      final chatModel = ChatModel(
          chatId: FirebaseHelper.getDocumenetId(FirebaseCollection.chats),
          messages: [],
          participants: ['${FirebaseHelper.getUserId()?.uid}', userProfileId]);
      await _chatService.createChat(chatModel: chatModel);
    } catch (e) {
      log('error create chat: ${e.toString()}');
    }
  }

  Future<void> sendChat(
      ChatMessage chatMessage, String userId1, String userId2) async {
    try {
      final messageModel = MessageModel(
          message: chatMessage.text,
          messageType: 'text',
          senderId: userId1,
          sentAt: chatMessage.createdAt);

      await _chatService.sendChatMessage(
          userId1: userId1, userId2: userId2, message: messageModel);
    } catch (e) {
      log('Send Chat Error: $e');
    }
  }
}
