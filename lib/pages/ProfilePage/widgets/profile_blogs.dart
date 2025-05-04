import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/blog_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileBlogs extends StatefulWidget {
  const ProfileBlogs({super.key});

  @override
  State<ProfileBlogs> createState() => _ProfileBlogsState();
}

class _ProfileBlogsState extends State<ProfileBlogs> {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final userId = authServices.uid;

    if (userId == null) {
      return Center(child: CircularProgressIndicator());
    }
    return StreamBuilder<QuerySnapshot>(
      stream: BlogDatabase().streamLoggedInUserBlogs(userId: userId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No blogs yet.'));
        }
        final blogs = snapshot.data!.docs;
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
