import 'package:flutter/material.dart';
import 'package:sobaca_mobile/models/thread.dart';
import 'package:sobaca_mobile/screens/chooseBookDiscussion.dart';
import 'package:sobaca_mobile/screens/threadDetail.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Future<List<Thread>> fetchThread() async {
    final request = context.watch<CookieRequest>();

    var response = await request
        .get('https://tajri.raisyam.my.id/discussion/show-thread-mobile');

    var data = response;

    List<Thread> listThread = [];
    for (var d in data) {
      if (d != null) {
        listThread.add(Thread.fromJson(d));
      }
    }
    listThread.sort((a, b) => b.dateCreate.compareTo(a.dateCreate));
    return listThread;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobaca Forum"),
        backgroundColor: Color(0xff8dc26f),
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: FutureBuilder(
        future: fetchThread(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No books available.",
                style: TextStyle(color: Color(0xff00a18c), fontSize: 20),
              ),
            );
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Belum Ada Thread yang dibuat. Silahkan inisiasi diskusi",
                    style: TextStyle(color: Color(0xff00a18c)),
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
                    elevation: 5, // Add elevation for shadow effect
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12.0),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(thread.book.image),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        thread.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00a18c),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Created By ${thread.user}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            '${thread.content}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ThreadDetailPage(thread: thread),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.playlist_add_outlined),
        tooltip: "Add New Discussion",
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChooseBookDiscussionPage(),
          ),
        ),
      ),
    );
  }
}
