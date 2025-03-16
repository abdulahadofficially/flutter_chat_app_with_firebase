import 'package:flutter_chat_app_with_firebase/models/message_model.dart';

class ChatModel {
  final String chatId;
  final List<MessageModel> messages;
  final List<String> participants;

  ChatModel({
    required this.chatId,
    required this.messages,
    required this.participants,
  });

    factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatId: map['chatId'] ?? '',
      messages: (map['messages'] as List<dynamic>)
          .map((message) => MessageModel.fromMap(message))
          .toList(),
      participants: List<String>.from(map['participants'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'messages': messages.map((message) => message.toMap()).toList(),
      'participants': participants,
    };
  }
}
