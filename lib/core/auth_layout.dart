import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/home_page.dart';
import 'package:firebase_connection_project/pages/SplashScreenPage/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthLayout extends StatefulWidget {
  const AuthLayout({super.key});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (snapshot.hasData) {
          final user = snapshot.data; // Get the User object
          final uid = user?.uid; // Extract the UID
          print('User UID: $uid');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<AuthServices>(context, listen: false).setUid(uid);
            print("_ ${Provider.of<AuthServices>(context, listen: false).uid}");
          });

          return HomePage(); // Navigate to HomePage if user is logged in
        } else {
          return SplashScreen(); // Navigate to SplashScreen if user is not logged in
        }
      },
    );
  }
}
