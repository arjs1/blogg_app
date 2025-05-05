import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDatabase {
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        // User not found
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  // to publish the register user credential to the database

  Future<void> saveUserData(
      // String uid,
      // String email,
      // String gender,
      // String username,
      BuildContext context) async {
    // print("from save userdata = " + uid + email + gender + username);
    try {
      final userData = Provider.of<AuthServices>(context, listen: false);
      print("__________ :: ${userData.uid}");
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData.uid)
          .set({
        'email': userData.email,
        'gender': userData.gender,
        'username': userData.userName,
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
