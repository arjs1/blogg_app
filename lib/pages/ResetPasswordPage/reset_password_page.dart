import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/pages/LoginPage/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailController = TextEditingController();
  String errorMessage = "";
  void resetPassword() async {
    try {
      await Provider.of<AuthServices>(context, listen: false)
          .forgetPassword(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Email Sent",
            style: GoogleFonts.poppins(fontSize: 19),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: GoogleFonts.poppins(fontSize: 19),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Reset Password"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 50,
          children: [
            SizedBox(
              height: 50,
            ),
            InputTextField(
              controller: emailController,
              hinttext: "Enter Email",
              obscuretext: false,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 60,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: MaterialButton(
                onPressed: () {
                  resetPassword();
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
