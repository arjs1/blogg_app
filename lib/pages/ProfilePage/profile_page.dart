import 'package:firebase_connection_project/core/const/capitalize_data.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/user_database.dart';
import 'package:firebase_connection_project/pages/ProfileInfo/profile_info.dart';
import 'package:firebase_connection_project/pages/ProfilePage/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthServices>(context, listen: false);
    final UserProfileData = UserDatabase();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: UserProfileData.getUserData(userData.uid.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return ListView(
                children: [
                  Text(
                    user["username"].toString().toTitleCase,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user["bio"].toString().toTitleCase,
                              style: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1,
                              child: MaterialButton(
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProfileInfo(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Profile info",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
              );
            } else {
              return Text("No data found");
            }
          },
        ),
      ),
    );
  }
}
