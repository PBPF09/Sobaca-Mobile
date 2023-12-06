// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:sobaca_mobile/models/thread.dart';
import 'package:sobaca_mobile/screens/threadDetail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumApp extends StatelessWidget {
  const ForumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Discussion Forum",
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Future<List<Thread>> fetchThread() async {
    final request = context.watch<CookieRequest>();

    var response = await request.get('http://localhost:8000/get-threads');

    var data = response;

    List<Thread> listThread = [];
    for (var d in data) {
      if (d != null) {
        listThread.add(Thread.fromJson(d));
      }
    }
    return listThread;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Discussion"),
      ),
      body: FutureBuilder(
          future: fetchThread(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Belum Ada Thread yang dibuat. Silahkan inisiasi diskusi",
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    SizedBox(height: 8.0),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      var thread = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(thread.fields.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                              )),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${thread.fields.title}'),
                              Text('${thread.fields.content}'),
                              Text('${thread.fields.user}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ThreadDetailPage(thread: thread),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    });
              }
            }
          }),
    );
  }
}
