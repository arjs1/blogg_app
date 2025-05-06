import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection_project/core/auth_layout.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/user_database.dart';
import 'package:firebase_connection_project/pages/LoginPage/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final bioController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reconfirmPasswordController = TextEditingController();
  String _selectedGender = 'male';
  String errorMessage = "";
  void signUp() async {
    try {
      await Provider.of<AuthServices>(context, listen: false).createUser(
          email: emailController.text, password: passwordController.text);

      Provider.of<AuthServices>(context, listen: false).setProfileData(
        username: usernameController.text,
        gender: _selectedGender,
        email: emailController.text,
        bio: bioController.text,
      );

      UserDatabase().saveUserData(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Successfully Signed Up",
            style: GoogleFonts.poppins(fontSize: 19),
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthLayout()),
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
        title: Text(
          "SIGNUP",
          style: TextStyle(
            letterSpacing: 8.0,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputTextField(
              controller: usernameController,
              hinttext: "Username",
              obscuretext: false),
          InputTextField(
            controller: bioController,
            hinttext: "Bio",
            obscuretext: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<String>(
                  value: 'male',
                  focusColor: Colors.black,
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary; // Color when selected
                    }
                    return Colors.grey; // Color when not selected
                  }),
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Male',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Radio<String>(
                  value: 'female',
                  focusColor: Colors.black,
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary; // Color when selected
                    }
                    return Colors.grey; // Color when not selected
                  }),
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          InputTextField(
              controller: emailController,
              hinttext: "Email",
              obscuretext: false),
          InputTextField(
              controller: passwordController,
              hinttext: "Password",
              obscuretext: true),
          InputTextField(
              controller: reconfirmPasswordController,
              hinttext: "Confirm Password",
              obscuretext: true),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 60,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: MaterialButton(
              onPressed: () {
                if (passwordController.text ==
                        reconfirmPasswordController.text ||
                    emailController.text != "" ||
                    usernameController.text != "") {
                  signUp();
                }
              },
              child: Text(
                "SignUp",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
