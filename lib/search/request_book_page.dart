// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class RequestBookPage extends StatefulWidget {
  const RequestBookPage({super.key});

  @override
  State<RequestBookPage> createState() => _RequestBookPageState();
}

class _RequestBookPageState extends State<RequestBookPage> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String author = "";
  int year = 0;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // print("${request.loggedIn} login atau belom");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Book"),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Request Book memungkinkan Anda mengajukan permintaan buku baru yang belum ada dalam koleksi. Isi formulir sederhana dan tim perpustakaan akan mempertimbangkan penambahan buku tersebut ke dalam katalog untuk meningkatkan variasi dan ketersediaan bacaan.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/images/request_book.png",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Title Book",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (String? value) {
                    setState(() {
                      title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Judul tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Author Book",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (String? value) {
                    setState(() {
                      author = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Penulis tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Year",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onChanged: (String? value) {
                    setState(() {
                      year = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Tahun tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Tahun harus berupa angka!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(125, 50),
                      backgroundColor: const Color(0xFF327957),
                      foregroundColor: const Color.fromARGB(255, 172, 115, 115)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final response = await request.postJson(
                          "https://tajri.raisyam.my.id/search_book/request/",
                          jsonEncode(<String, String>{
                            'title': title,
                            'author': author,
                            'year': year.toString(),
                          }),
                        );

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Request buku berhasil disimpan!"),
                          ));
                          Navigator.pop(context);
                        } else {
                          // Handle kesalahan lainnya jika respons tidak sesuai dengan format yang diharapkan
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Terdapat kesalahan: ${response['message']}"),
                          ));
                        }
                      } catch (error) {
                        // Handle kesalahan umum atau respons yang tidak sesuai dengan format JSON
                        print("Error: $error");
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ));
                      }
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.data_saver_on_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Save")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
