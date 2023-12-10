import 'package:flutter/material.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';
import 'package:sobaca_mobile/widgets/menuCard.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final List<MenuItem> items = [
    MenuItem("Book Catalogs", Icons.library_books_outlined, [Color(0xff76b852), Color(0xff8dc26f)]),
    MenuItem("Discussions", Icons.question_answer_outlined, [Color(0xff76b852), Color(0xff8dc26f)]),
    MenuItem("Literacy Objectives", Icons.emoji_events_outlined, [Color(0xff76b852), Color(0xff8dc26f)]),
    MenuItem("Search", Icons.manage_search_outlined, [Color(0xff76b852), Color(0xff8dc26f)]),
    MenuItem("Logout", Icons.logout_outlined, [Color(0xff76b852), Color(0xff8dc26f)]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child : Text(
          'Sobaca Menu\'s',
          )
        ),
      ),
      drawer: LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'Sobaca Menu', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((MenuItem item) {
                  // Iterasi untuk setiap item
                  return MenuCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
