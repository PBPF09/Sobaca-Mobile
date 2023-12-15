import 'package:flutter/material.dart';
import 'package:sobaca_mobile/user_registered/screens/favoriteBooksPage.dart';
import 'package:sobaca_mobile/screens/forumPage.dart';
import 'package:sobaca_mobile/screens/menuHome.dart';
import 'package:sobaca_mobile/authentication/login.dart';

class MenuItem {
  final String name;
  final IconData icon;
  final List<Color> color;

  MenuItem(this.name, this.icon, this.color);
}

class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () {
          if (item.name == "Book Catalogs") {
            // Navigator.push(context,
            //   MaterialPageRoute(builder: ((context) => const CatalogPage())));
          } else if (item.name == "Discussions") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
          } else if (item.name == "Challenges") {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const ChallengePage()));
          } else if (item.name == "Search") {
            // Navigator.push(context,
            // MaterialPageRoute(builder: ((context) => const SearchPage())));
          } else if (item.name == "Favorite") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const FavoriteBooksPage())));
          } else if (item.name == "Logout") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
