import 'package:flutter/material.dart';
import 'package:sobaca_mobile/authentication/login.dart';
import 'package:sobaca_mobile/objectives/screens/list_objective.dart';
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
                colors: [Color(0xff76b852), Color(0xff8dc26f)],
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
                )),
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            title: Text('Book Catalogs'),
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const CatalogPage(),
              //         settings: RouteSettings(name: 'CatalogPage')),
              //     (route) =>
              //         route.isFirst || route.settings.name == 'HomePage'
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text('Discussion'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForumPage(),
                      settings: RouteSettings(name: 'ForumPage')),
                  (route) =>
                      route.isFirst || route.settings.name == 'HomePage');
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_search_outlined),
            title: Text('Search Books'),
            onTap: () {
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SearchPage(),
              //         settings: RouteSettings(name: 'SearchPage')),
              //     (route) =>
              //         route.isFirst || route.settings.name == 'HomePage'
              // );
            },
          ),
          ListTile(
            leading: Icon(Icons.emoji_events_outlined),
            title: Text('Literacy Objectives'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ObjectivesPage(),
                      settings: RouteSettings(name: 'ObjectivePage')),
                  (route) =>
                      route.isFirst || route.settings.name == 'HomePage'
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const LoginPage())),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
