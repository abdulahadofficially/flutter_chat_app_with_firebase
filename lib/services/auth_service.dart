import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  AuthServices() {}
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<UserCredential> register(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthException(e));
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    return e.code;
  }
}
