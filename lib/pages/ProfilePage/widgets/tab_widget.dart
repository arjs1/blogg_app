import 'package:firebase_connection_project/pages/ProfilePage/widgets/bookmark_blogs.dart';
import 'package:firebase_connection_project/pages/ProfilePage/widgets/profile_blogs.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
  });

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            dividerHeight: 0,
            unselectedLabelColor: const Color.fromARGB(255, 116, 116, 116),
            tabs: [
              Icon(
                Icons.grid_view_rounded,
                size: 25,
              ),
              Icon(
                Icons.bookmark,
                size: 25,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                ProfileBlogs(),
                BookmarkBlogs(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
