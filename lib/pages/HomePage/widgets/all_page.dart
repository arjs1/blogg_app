import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/blog_container.dart';
import 'package:flutter/material.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: BlogDatabase().streamAllBlogs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No blogs yet.'));
        }
        final blogs = snapshot.data!.docs;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: blogs.length,
          itemBuilder: (context, index) {
            final blog = blogs[index];
            return BlogContainer(
              blog: blog,
            );
          },
        );
      },
    );
  }
}
