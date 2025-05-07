import 'package:firebase_connection_project/pages/HomePage/widgets/all_page.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/category_page.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/title_head.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            TitleHead(),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 5,
            ),
            DefaultTabController(
              length: 10,
              child: Column(
                children: [
                  TabBar(
                    isScrollable: true,
                    dividerHeight: 0,
                    unselectedLabelColor:
                        const Color.fromARGB(255, 116, 116, 116),
                    tabs: [
                      Text(
                        "All",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Technology",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Travel",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Lifestyle",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Fashion",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Finance",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Music",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Marketing",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Movies",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Politics",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        AllPage(),
                        CategoryPage(
                          categoryName: "Technology",
                        ),
                        CategoryPage(
                          categoryName: "Travel",
                        ),
                        CategoryPage(
                          categoryName: "Lifestyle",
                        ),
                        CategoryPage(
                          categoryName: "Fashion",
                        ),
                        CategoryPage(
                          categoryName: "Finance",
                        ),
                        CategoryPage(
                          categoryName: "Music",
                        ),
                        CategoryPage(
                          categoryName: "Marketing",
                        ),
                        CategoryPage(
                          categoryName: "Movies",
                        ),
                        CategoryPage(
                          categoryName: "Politics",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // TextButton(
            //     onPressed: () async {
            //       await Provider.of<AuthServices>(context, listen: false)
            //           .signOut();
            //     },
            //     child: Text("signout"))
          ],
        ),
      ),
    );
  }
}
