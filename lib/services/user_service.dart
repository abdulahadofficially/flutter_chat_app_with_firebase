import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app_with_firebase/constants/firebase_collection.dart';
import 'package:flutter_chat_app_with_firebase/helpers/firebase_helper.dart';
import 'package:flutter_chat_app_with_firebase/models/user_model.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel userModel) async {
    try {
      await _firebaseFirestore
          .collection(FirebaseCollection.userCollection)
          .doc(userModel.id)
          .set(userModel.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }
  Stream<List<UserModel>> getUsers() {
    try {
      return _firebaseFirestore
          .collection(FirebaseCollection.userCollection)
          .where('id', isNotEqualTo: FirebaseHelper.getUserId()?.uid)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => UserModel.fromMap(doc.data()))
              .toList());
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }
}
