import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDatabase {
  // to publish the register user credential to the database

  Future<void> saveUserData(BuildContext context) async {
    try {
      final userData = Provider.of<AuthServices>(context, listen: false);
      // print("__________ :: ${userData.uid}");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.uid)
          .set({
        'email': userData.email,
        'gender': userData.gender,
        'username': userData.userName,
        "bio": userData.bio,
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (docSnapshot.exists) {
        return docSnapshot.data(); // returns a Map<String, dynamic>
      } else {
        return null; // user not found
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
