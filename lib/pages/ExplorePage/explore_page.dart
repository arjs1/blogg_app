import 'package:firebase_connection_project/pages/ExplorePage/widgets/category_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<String> categoryList = [
    "Technology",
    "Travel",
    "lifestyle",
    "Fashion",
    "News",
    "Food",
    "Finance",
    "Music",
    "Marketing",
    "Movies",
    "Politics",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore Your Curiosity",
          style: GoogleFonts.poppins(fontSize: 25),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GridView.builder(
        cacheExtent: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categoryList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryPage(categoryName: categoryName)));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 20,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    categoryList[index],
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
