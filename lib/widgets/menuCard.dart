import 'package:flutter/material.dart';
import 'package:sobaca_mobile/objectives/screens/list_objective.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/books_catalog/catalogs.dart';
import 'package:sobaca_mobile/user_registered/screens/favoriteBooksPage.dart';
import 'package:sobaca_mobile/forum/screens/forumPage.dart';
import 'package:sobaca_mobile/authentication/login.dart';
import 'package:sobaca_mobile/search/search_page.dart';


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
    final request = context.watch<CookieRequest>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: item.color,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () async {
          if (item.name == "Book Catalogs") {
            Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const CatalogPage())));
          } else if (item.name == "Discussions") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
          } else if (item.name == "Literacy Objectives") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ObjectivesPage()));
          } else if (item.name == "Search") {
            Navigator.push(context, 
            MaterialPageRoute(builder: ((context) => const SearchPage())));
          } else if (item.name == "Favorite Books") {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const FavoriteBooksPage())));
          } else if (item.name == "Logout") {
            final response = await request.logout(
            "https://tajri.raisyam.my.id/auth/logout/");
            String message = response["message"];
            if (response['status']) {
              String uname = response["username"];
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
              ));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message"),
              ));
            }
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
