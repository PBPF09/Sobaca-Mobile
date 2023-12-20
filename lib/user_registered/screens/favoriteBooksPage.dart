import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';
import 'package:sobaca_mobile/user_registered/models/favorite.dart';

class FavoriteBooksPage extends StatefulWidget {
  const FavoriteBooksPage({Key? key}) : super(key: key);

  @override
  _FavoriteBooksPageState createState() => _FavoriteBooksPageState();
}

class _FavoriteBooksPageState extends State<FavoriteBooksPage> {
  Future<List<Favorite>> fetchFavorite() async {
    final request = context.watch<CookieRequest>();
    var response =
        await request.get('https://tajri.raisyam.my.id/user_registered/get_favorite');

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
    final request = context.watch<CookieRequest>();
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
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada buku yang ditambahkan di favorit.",
                  style: TextStyle(color: Color(0xff00a18c), fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(snapshot.data![index].fields.title),
                    subtitle: Text(snapshot.data![index].fields.author),
                    leading: Image.network(
                      snapshot.data![index].fields.images,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await request.post(
                            "https://tajri.raisyam.my.id/user_registered/delete_favorite_flutter/${snapshot.data![index].pk}",
                            {});
                        setState(() {});
                      },
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
