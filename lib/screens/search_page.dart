// ignore_for_file: unnecessary_string_interpolations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/models/books.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:sobaca_mobile/screens/request_book_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _input = TextEditingController();
  int boldTextIndex = 0;
  List<Book> _result = [];
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    fetchBooksByTyping("");
    daftarGenre.sort((a, b) {
      if (a == 'All') {
        return -1; // 'All' should come first
      } else if (b == 'All') {
        return 1; // 'All' should come first
      } else {
        return a.compareTo(b);
      }
    });
  }

  Future<void> fetchBooksByGenre(String genre) async {
    try {
      var url = Uri.parse('http://localhost:8000/api/books/genres/$genre');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Book
      setState(() {
        _result = data.map((book) => Book.fromJson(book)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Tidak dapat memproses permintaan Anda. Silakan login terlebih dahulu."),
      ));
    }
  }

  Future<void> fetchBooksByTyping(String typing) async {
    try {
      var url = Uri.parse('http://localhost:8000/api/books/$typing');
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      // melakukan decode response menjadi bentuk json
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      // melakukan konversi data json menjadi object Book
      setState(() {
        _result = data.map((book) => Book.fromJson(book)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Tidak dapat memproses permintaan Anda. Silakan login terlebih dahulu."),
      ));
    }
  }

  Future<void> fetchBooksByOrder(String order) async {
    try {
      var url =
          Uri.parse('http://localhost:8000/api/books/order-by/$order/');
      var response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );

      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _result = data.map((book) => Book.fromJson(book)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Tidak dapat memproses permintaan Anda. Silakan login terlebih dahulu."),
      ));
    }
  }

  void showAccessDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Access Denied'),
          content: Text('Permintaan Anda saat ini tidak dapat diproses. Silakan login terlebih dahulu.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<String> daftarGenre = [
    'All',
    'Fiction',
    'Drama',
    'History',
    'Juvenile Fiction',
    'Psychology',
    'Games',
    'Chile',
    'Comics & Graphic Novels',
    'Biography & Autobiography',
    'Poetry',
    'Family & Relationships',
    'Health & Fitness',
    'Business & Economics',
    'Humor',
    'Czech Americans',
    'Travel',
    'Education',
    'Literary Collections',
    'Religion',
    'Young Adult Fiction',
    'Literary Criticism',
    'Self-Help',
    'True Crime',
    'Curiosities and wonders'
  ];

  @override
  Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
  // print("${request.loggedIn} ini login atau tidak");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Book",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: _input,
              decoration: InputDecoration(
                  hintText: "Search Sobaca",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              onChanged: (input) {
                if (request.loggedIn) {
                  setState(() {
                    boldTextIndex = 0;
                  });
                  fetchBooksByTyping(input);

                } else {
                  showAccessDeniedDialog(context);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: daftarGenre
                    .asMap()
                    .entries
                    .map(
                      (entry) => InkWell(
                        onTap: () {
                          if (request.loggedIn){
                            setState(() {
                              boldTextIndex = entry.key;
                              _input.clear();
                            });
                            fetchBooksByGenre(entry.value);

                          } else {
                            showAccessDeniedDialog(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontWeight: boldTextIndex == entry.key
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                if (request.loggedIn){
                  if (isAscending) {
                    // fetchBooksByAscending();
                    fetchBooksByOrder("ascending");
                  } else {
                    // fetchBooksByDescending();
                    fetchBooksByOrder("descending");
                  }
                  setState(() {
                    isAscending = !isAscending;
                    boldTextIndex = 0;
                  });

                } else {
                  showAccessDeniedDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF327957),
                  foregroundColor: Colors.white),
              child: isAscending
                  ? const Icon(Icons.arrow_drop_up_rounded)
                  : const Icon(Icons.arrow_drop_down_rounded),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: (_result.length / 2).ceil(),
                separatorBuilder: (_, index) => const SizedBox(
                  height: 30.0,
                ),
                itemBuilder: (_, index) {
                  int startIndex = index * 2;
                  int endIndex = (index + 1) * 2;
                  if (endIndex > _result.length) {
                    endIndex = _result.length;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(endIndex - startIndex, (i) {
                      int currentIndex = startIndex + i;
                      // ignore: sized_box_for_whitespace
                      return Container(
                        height: 300,
                        width: 160, // Adjust the fixed width as needed
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowBook(_result[currentIndex].pk)));
                          },
                          child: Container(
                            width: 147,
                            height: 285, // Adjust height as needed
                            padding: const EdgeInsets.only(
                                top: 15, left: 8, right: 8, bottom: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF327957),
                                borderRadius: BorderRadius.circular(30)),
                            clipBehavior: Clip.none,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "${_result[currentIndex].fields.images}",
                                  width: 130,
                                  height: 127,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${_result[currentIndex].fields.title}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${_result[currentIndex].fields.author}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${_result[currentIndex].fields.categories.replaceAll(RegExp(r"[\[\]']"), "")}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
      // ignore: sized_box_for_whitespace
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF327957),
          foregroundColor: const Color(0xFFFFFFFF),
          mini: true,
          onPressed: () {
            if (request.loggedIn){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RequestBookPage()));

            } else {
              showAccessDeniedDialog(context);
            }
          },
          child: const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(Icons.library_books_outlined),
              SizedBox(
                width: 10,
              ),
              Text("Request Book")
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
