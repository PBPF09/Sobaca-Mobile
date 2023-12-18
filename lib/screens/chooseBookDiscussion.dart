import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sobaca_mobile/screens/createForum.dart';
import 'package:sobaca_mobile/models/books.dart';
import 'package:sobaca_mobile/widgets/leftDrawer.dart';

class ChooseBookDiscussionPage extends StatefulWidget {
  const ChooseBookDiscussionPage({Key? key}) : super(key: key);

  @override
  State<ChooseBookDiscussionPage> createState() =>
      _ChooseBookDiscussionPageState();
}

class _ChooseBookDiscussionPageState extends State<ChooseBookDiscussionPage> {
  Future<List<Book>> fetchBooks() async {
    final url = Uri.parse('https://tajri.raisyam.my.id/discussion/get-book');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((d) => Book.fromJson(d)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Sobaca Forum"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xff8dc26f),
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Failed to load books",
                style: TextStyle(color: Color(0xff00a18c)),
              ),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada buku yang tersedia",
                style: TextStyle(color: Color(0xff00a18c)),
              ),
            );
          } else {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 13.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 9 / 16,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThreadFormPage(book: book),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      gradient: const LinearGradient(
                        colors: [Color(0xff76b852), Color(0xff8dc26f)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4.0,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              book.fields.images,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.fields.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  book.fields.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
