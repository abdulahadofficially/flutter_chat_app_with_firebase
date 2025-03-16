import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String messageType;
  final String senderId;
  final DateTime sentAt;

  MessageModel({
    required this.message,
    required this.messageType,
    required this.senderId,
    required this.sentAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      messageType: map['messageType'] ?? 'text',
      senderId: map['senderId'] ?? '',
      sentAt: (map['sentAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'messageType': messageType,
      'senderId': senderId,
      'sentAt': sentAt,
    };
  }
}
