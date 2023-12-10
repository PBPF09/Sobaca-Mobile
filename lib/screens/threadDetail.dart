import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sobaca_mobile/models/thread.dart';
import 'package:sobaca_mobile/models/reply.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ThreadDetailPage extends StatefulWidget {
  final Thread thread;

  const ThreadDetailPage({Key? key, required this.thread}) : super(key: key);

  @override
  _ThreadDetailPageState createState() => _ThreadDetailPageState();
}

class _ThreadDetailPageState extends State<ThreadDetailPage> {
  TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xff8dc26f),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: fetchReply(context, widget.thread),
        builder: (context, AsyncSnapshot<List<Reply>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Reply> replies = snapshot.data ?? [];
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Hero(
                        tag: 'bookImage${widget.thread.id}',
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.thread.book.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.thread.book.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.thread.book.author,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.thread.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Created by ${widget.thread.user} - ${formatDate(widget.thread.dateCreate)}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              widget.thread.content,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Divider(),
                      SizedBox(height: 16),
                      for (var reply in replies)
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(reply.content),
                          subtitle: Text(
                              'Created by ${reply.user} - ${formatDate(reply.dateCreate)}'),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _replyController,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Your Reply...',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (_replyController.text.isNotEmpty) {
                            final request =
                                context.read<CookieRequest>();

                            final response = await request.postJson(
                              'http://localhost:8000/discussion/add-reply-mobile/',
                              jsonEncode(<String, dynamic>{
                                'content': _replyController.text,
                                'threadId': widget.thread.id.toString(),
                              }),
                            );

                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Reply successfully sent!"),
                                ),
                              );
                              setState(() {
                                _replyController.clear();
                              });

                              List<Reply> updatedReplies =
                                  await fetchReply(context, widget.thread);
                              setState(() {
                                replies = updatedReplies;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("There was an error sending the reply."),
                                ),
                              );
                            }
                            setState(() {
                              _replyController.clear();
                            });
                          }
                        },
                        icon: Icon(Icons.send),
                        tooltip: 'Send Reply',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    String formattedDate =
        DateFormat('EEEE, MMMM d y, HH:mm a').format(dateTime);
    return formattedDate;
  }

  Future<List<Reply>> fetchReply(BuildContext context, Thread thread) async {
    final request = context.watch<CookieRequest>();
    var threadId = thread.id;
    var response = await request
        .get('http://localhost:8000/discussion/show-reply-mobile/$threadId');

    var data = response;

    List<Reply> listReply = [];
    for (var d in data) {
      if (d != null) {
        listReply.add(Reply.fromJson(d));
      }
    }
    listReply.sort((a, b) => b.dateCreate.compareTo(a.dateCreate));
    return listReply;
  }
}
