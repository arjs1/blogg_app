import 'package:firebase_connection_project/pages/ProfilePage/widgets/data_container.dart';
import 'package:firebase_connection_project/pages/ProfilePage/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(
              children: [
                Text(
                  "Username",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DataContainer(
                          countNumber: "116",
                          countName: "posts",
                        ),
                        DataContainer(
                          countNumber: "449",
                          countName: "followers",
                        ),
                        DataContainer(
                          countNumber: "661",
                          countName: "following",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                "Write your bio here",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 50,
              child: MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                child: Text("Edit Profile"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 0.6,
            ),
            SizedBox(
              height: 10,
            ),
            //---- tab bar for profile page ---//
            TabWidget(),
          ],
        ),
      ),
    );
  }
}
