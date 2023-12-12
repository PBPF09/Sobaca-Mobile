import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sobaca_mobile/user_registered/models/favorite.dart';
import 'package:sobaca_mobile/models/books.dart';

class FavoriteBooksPage extends StatefulWidget {
  const FavoriteBooksPage({Key? key}) : super(key: key);

  @override
  _FavoriteBooksPageState createState() => _FavoriteBooksPageState();
}

class _FavoriteBooksPageState extends State<FavoriteBooksPage> {
  Future<List<Favorite>> fetchFavorite() async {
    final request = context.watch<CookieRequest>();
    var response =
        await request.get('http://localhost:8000/user_registered/get_favorite');

    var data = response;
    List<Favorite> listFavorite = [];

    for (var d in data) {
      if (d != null) {
        listFavorite.add(Favorite.fromJson(d));
      }
    }

    return listFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Books'),
        ),
        drawer: LeftDrawer(),
        body: FutureBuilder(
            future: fetchFavorite(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Belum ada buku yang ditambahkan di favorit.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Image.network(
                            snapshot.data![index].fields.images,
                            width: 100,
                            height: 150,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "${snapshot.data![index].fields.title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.author}"),
                        ],
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
