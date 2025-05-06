import 'package:firebase_connection_project/core/const/capitalize_data.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/user_database.dart';
import 'package:firebase_connection_project/core/provider/theme_provider.dart';
import 'package:firebase_connection_project/pages/ProfileInfo/widgets/profile_data_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthServices>(context, listen: false);
    final UserProfileData = UserDatabase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Profile info",
          style: GoogleFonts.poppins(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: UserProfileData.getUserData(userData.uid.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator.adaptive();
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ProfileDataContainer(
                          containerData:
                              user["username"].toString().toTitleCase,
                          containerName: "Username",
                          isRequired: false,
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
                        ProfileDataContainer(
                          containerData: user["email"].toString(),
                          containerName: "Email",
                          isRequired: false,
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
                        ProfileDataContainer(
                          containerData: user["gender"].toString(),
                          containerName: "gender",
                          isRequired: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1,
                          height: 50,
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () async {
                              await Provider.of<AuthServices>(context,
                                      listen: false)
                                  .signOut();
                            },
                            child: Text(
                              "Logout",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
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
