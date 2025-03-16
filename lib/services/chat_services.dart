import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app_with_firebase/constants/firebase_collection.dart';
import 'package:flutter_chat_app_with_firebase/models/chat_model.dart';
import 'dart:developer';
import '../models/message_model.dart';

class ChatServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createChat({required ChatModel chatModel}) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollection.chats)
          .doc(chatModel.chatId)
          .set(chatModel.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<DocumentReference?> getChatReference({
    required String userId1,
    required String userId2,
  }) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollection.chats)
          .where('participants', arrayContains: userId1)
          .get();

      for (var doc in querySnapshot.docs) {
        List<dynamic> participants = doc['participants'];
        if (participants.contains(userId2)) {
          return doc.reference;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> sendChatMessage(
      {required String userId1,
      required String userId2,
      required MessageModel message}) async {
    try {
      DocumentReference? chatId =
          await getChatReference(userId1: userId1, userId2: userId2);
      await _firebaseFirestore
          .collection(FirebaseCollection.chats)
          .doc(chatId?.id)
          .update({
        'messages': FieldValue.arrayUnion([message.toMap()])
      });
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

 Stream<ChatModel?> getChat({
  required String userId1,
  required String userId2,
}) async* {
  try {
    final chatRef = await getChatReference(userId1: userId1, userId2: userId2);

    if (chatRef != null) {
      yield* _firebaseFirestore
          .collection(FirebaseCollection.chats)
          .doc(chatRef.id)
          .withConverter<ChatModel>(
            fromFirestore: (snapshot, _) =>
                ChatModel.fromMap(snapshot.data() ?? {}),
            toFirestore: (chat, _) => chat.toMap(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data());
    } else {
      yield null; // No chat exists yet
    }
  } catch (e) {
    log('Get Chat Error: $e');
    yield null;
  }
}

}
