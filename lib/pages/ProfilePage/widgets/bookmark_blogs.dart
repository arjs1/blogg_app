import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/blog_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkBlogs extends StatefulWidget {
  const BookmarkBlogs({super.key});

  @override
  State<BookmarkBlogs> createState() => _BookmarkBlogsState();
}

class _BookmarkBlogsState extends State<BookmarkBlogs> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final userId = authServices.uid;

    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: BlogDatabase().streamLoggedInSavedBlogs(uid: userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No saved blogs yet.'));
        }

        final blogs = snapshot.data!;

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            final blog = blogs[index];
            return BlogContainer(blog: blog);
          },
        );
      },
    );
  }
}
