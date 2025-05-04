import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  // maintains the state
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();
  String? _uid;

  String? get uid => _uid;

  void setUid(String? uid) {
    _uid = uid;
    notifyListeners(); // Notify listeners when the UID changes
  }

  // for signin
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  // for creating a user
  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // for signout
  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  // for forget password

  Future<void> forgetPassword({required String email}) async {
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
