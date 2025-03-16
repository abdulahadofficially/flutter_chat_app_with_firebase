import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  FirebaseHelper._();
  static final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  static String getDocumenetId(String collectionPath) =>
      _firebaseStore.collection(collectionPath).doc().id;

  static User? getUserId() {
    return FirebaseAuth.instance.currentUser;
  }
}
