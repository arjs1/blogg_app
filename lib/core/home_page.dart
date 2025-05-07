import 'package:firebase_connection_project/pages/CreatePage/create_page.dart';
import 'package:firebase_connection_project/pages/HomePage/home_main_page.dart';
import 'package:firebase_connection_project/pages/ProfilePage/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> page = [
    HomeMainPage(),
    CreatePage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: page[_currentIndex],
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.primary,
          height: 120,
          child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Theme.of(context).colorScheme.primary,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey.shade400,
              selectedItemColor: Colors.white,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]),
        ));
  }
}
