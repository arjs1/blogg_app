import 'package:firebase_connection_project/pages/LoginPage/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "InkSphere",
                      style: GoogleFonts.amaticSc(
                        fontSize: 50,
                        letterSpacing: 6.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Empower your voice.".toUpperCase(),
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 60,
                                  letterSpacing: 2.0,
                                  height: 1,
                                ),
                              ),
                              Text(
                                "Illuminate minds.".toUpperCase(),
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 60,
                                  letterSpacing: 2.0,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: width / 1.2,
                          height: 60,
                          color: Theme.of(context).colorScheme.surface,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              "Start to Read",
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
