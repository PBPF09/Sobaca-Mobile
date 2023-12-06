import 'package:flutter/material.dart';
import 'package:sobaca_mobile/models/thread.dart';
import 'package:sobaca_mobile/models/reply.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ThreadDetailPage extends StatelessWidget {
  final Thread thread;

  const ThreadDetailPage({Key? key, required this.thread}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(thread.fields.title),
      ),
      body: FutureBuilder(
        future: fetchReply(context, thread), // Sertakan parameter context di sini
        builder: (context, AsyncSnapshot<List<Reply>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Reply> replies = snapshot.data ?? [];
            return ListView(
              children: [
                ListTile(
                  title: Text('Title: ${thread.fields.title}'),
                  subtitle: Text('Content: ${thread.fields.content}'),
                ),
                for (var reply in replies)
                  ListTile(
                    title: Text(reply.fields.content),
                    // Tambahkan informasi lainnya sesuai kebutuhan
                  ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<List<Reply>> fetchReply(BuildContext context, Thread thread) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = await request.get('http://localhost:8000/get-reply/${thread.pk}');

    var data = response;

    List<Reply> listReply = [];
    for (var d in data) {
      if (d != null) {
        listReply.add(Reply.fromJson(d));
      }
    }
    return listReply;
  }
}
