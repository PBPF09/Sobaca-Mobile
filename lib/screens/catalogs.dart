import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sobaca_mobile/details/details_screen.dart';
import 'package:sobaca_mobile/models/books.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

import 'package:sobaca_mobile/screens/search_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int boldTextIndex = 0;
  List<Book> _result = [];
  Future<void> fetchBooksByOrder(String order) async {
    try {
      var url =
          Uri.parse('https://tajri.raisyam.my.id/api/books/order-by/$order/');
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

  @override
  void initState() {
    super.initState();
    fetchBooksByOrder("ascending");
  }

  @override
  Widget build(BuildContext context) {
    // tampilkan semua buku yang ada di database dalam bentuk list
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogs"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SearchPage())));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      boldTextIndex = 0;
                      fetchBooksByOrder("ascending");
                    });
                  },
                  child: Text(
                    "Ascending",
                    style: GoogleFonts.poppins(
                      fontWeight: boldTextIndex == 0
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      boldTextIndex = 1;
                      fetchBooksByOrder("descending");
                    });
                  },
                  child: Text(
                    "Descending",
                    style: GoogleFonts.poppins(
                      fontWeight: boldTextIndex == 1
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _result.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBuku(
                            _result[index],
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                      _result[index].fields.images,
                      width: 100,
                    ),
                    title: Text(_result[index].fields.title),
                    subtitle: Text(_result[index].fields.author),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
