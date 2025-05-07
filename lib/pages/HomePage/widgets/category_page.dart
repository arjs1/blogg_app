import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/blog_container.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final StreamController<List<DocumentSnapshot>> _streamController =
      StreamController<List<DocumentSnapshot>>();

  @override
  void initState() {
    super.initState();
    BlogDatabase()
        .streamCategorizedBlogs(category: widget.categoryName)
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _streamController.add(snapshot.docs);
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: _streamController.stream,
      builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No blogs yet.'));
        }
        final blogs = snapshot.data!;

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
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
