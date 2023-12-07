import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sobaca_mobile/authentication/login.dart';
import 'package:sobaca_mobile/screens/forumPage.dart';
import 'package:sobaca_mobile/screens/menuHome.dart';


class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.greenAccent],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                  'assets/images/sobaca_logo.png',
                  fit: BoxFit.contain,
                  )
                ),
                Text(
                  'Sobaca',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Inspirasi Literasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text('Book Catalogs'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CatalogPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text('Discussion'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForumPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_search_outlined),
            title: Text('Search Books'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_events_outlined),
            title: Text('Book Challenges'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const ChallengePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: ((context) => const LoginPage())));
            },
          ),
        ],
      ),
    );
  }
}
