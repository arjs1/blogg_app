import 'package:firebase_connection_project/core/const/capitalize_data.dart';
import 'package:firebase_connection_project/pages/BlogDetailPage/blog_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogContainer extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final blog;
  const BlogContainer({super.key, required this.blog});

  @override
  State<BlogContainer> createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailPage(
              blog: widget.blog,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            widget.blog["title"].toString().toTitleCase,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontSize: 30, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.blog["description"].toString().toCapitalized,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            // softWrap: false,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 0.8,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
