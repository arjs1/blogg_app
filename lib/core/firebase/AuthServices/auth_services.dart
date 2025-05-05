import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  // maintains the state
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();
  String? _uid;
  String? _userName, _gender, _email;
  String? get userName => _userName;
  String? get gender => _gender;
  String? get email => _email;

  String? get uid => _uid;

  void setUid(String? uid) {
    _uid = uid;
    notifyListeners(); // Notify listeners when the UID changes
  }

  void setProfileData({String? username, String? gender, String? email}) {
    _userName = username;
    _email = email;
    _gender = gender;
    notifyListeners();
  }

  // for signin
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    setUid(userCredential.user?.uid); // Set the UID after sign-in
    return userCredential;
  }

  // for creating a user
  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    setUid(userCredential.user?.uid); // Set the UID after user creation
    return userCredential;
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
