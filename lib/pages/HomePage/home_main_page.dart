import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_project/core/firebase/AuthServices/auth_services.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/blog_database.dart';
import 'package:firebase_connection_project/core/firebase/DatabaseServices/user_database.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/blog_container.dart';
import 'package:firebase_connection_project/pages/HomePage/widgets/title_head.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  // final userData = UserDatabase().getUserData("qnp2XbR0Y7XbK9CUf195k6n9kQa2");s
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
            StreamBuilder<QuerySnapshot>(
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
