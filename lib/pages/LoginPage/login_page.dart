import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection_project/core/auth_layout.dart';

import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/provider/theme_provider.dart';
import 'package:firebase_connection_project/pages/LoginPage/widgets/input_text_field.dart';
import 'package:firebase_connection_project/pages/ResetPasswordPage/reset_password_page.dart';
import 'package:firebase_connection_project/pages/SignupPage/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = "";
  void login() async {
    try {
      await Provider.of<AuthServices>(context, listen: false).signIn(
          email: emailController.text, password: passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Successfully Logged In",
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
            "LOGIN",
            style: TextStyle(
              letterSpacing: 8.0,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleApperance();
                },
                icon: Provider.of<ThemeProvider>(context).ispressed
                    ? Icon(Icons.nightlight_round_outlined)
                    : Icon(Icons.light_mode)),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    image: DecorationImage(
                      opacity: 0.2,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/login.jpg"),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "InkSphere",
                      style: GoogleFonts.amaticSc(
                        fontSize: 50,
                        letterSpacing: 6.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    InputTextField(
                        controller: emailController,
                        hinttext: "Email",
                        obscuretext: false),
                    SizedBox(
                      height: 30,
                    ),
                    InputTextField(
                      controller: passwordController,
                      hinttext: "Password",
                      obscuretext: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()));
                          },
                          child: Text(
                            "Forget Password?",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: MaterialButton(
                        onPressed: () {
                          login();
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
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: Text("Don't have an account? SignUp"))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
