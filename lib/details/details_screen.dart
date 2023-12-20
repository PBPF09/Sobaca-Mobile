import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sobaca_mobile/details/add_review.dart';
import 'package:sobaca_mobile/details/all_reviews.dart';
import 'package:sobaca_mobile/details/deskripsi_screen.dart';
import 'package:sobaca_mobile/models/books.dart';
import 'package:sobaca_mobile/models/reviews.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class DetailBuku extends StatefulWidget {
  final Book book;

  const DetailBuku(this.book, {Key? key}) : super(key: key);

  @override
  State<DetailBuku> createState() => _DetailBukuState();
}

class _DetailBukuState extends State<DetailBuku> {
  int get idBuku => widget.book.pk;
  String get apiUrl => 'https://tajri.raisyam.my.id/book/get-reviews/$idBuku';
  bool isFavorited = false;

  Future<List<Reviews>> fetchReview() async {
    final request = context.watch<CookieRequest>();

    var response = await request.get(apiUrl);

    var data = response;

    List<Reviews> listReview = [];
    for (var d in data) {
      if (d != null) {
        listReview.add(Reviews.fromJson(d));
      }
    }
    listReview.sort((a, b) => b.waktu.compareTo(a.waktu));
    return listReview;
  }

  Future<void> addWantToRead() async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request.post(
          'https://tajri.raisyam.my.id/book/add-want-to-read/$idBuku', {});

      if (response['status'] == 'success') {
        // Show success alert
        _showAlert('Buku berhasil ditambahkan ke rak Ingin Dibaca');
      } else {
        // Show failure alert
        _showAlert('Gagal menambahkan buku ke rak Ingin Dibaca');
      }
    } catch (error) {
      // Handle errors
      print('Error adding to Want to Read: $error');
    }
  }

  Future<void> addReading() async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request
          .post('https://tajri.raisyam.my.id/book/add-reading/$idBuku', {});

      if (response['status'] == 'success') {
        // Show success alert
        _showAlert('Buku berhasil ditambahkan ke rak Sedang Dibaca');
      } else {
        // Show failure alert
        _showAlert('Gagal menambahkan buku ke rak Sedang Dibaca');
      }
    } catch (error) {
      // Handle errors
      print('Error adding to Currently Reading: $error');
    }
  }

  Future<void> addRead() async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request.post(
        'https://tajri.raisyam.my.id/book/add-read/$idBuku',
        {},
      );

      if (response['status'] == 'success') {
        // Show success alert
        _showAlert('Buku berhasil ditambahkan ke rak Sudah Dibaca');
      } else {
        // Show failure alert
        _showAlert('Gagal menambahkan buku ke rak Sudah Dibaca');
      }
    } catch (error) {
      // Handle errors
      print('Error adding to Already Read: $error');
    }
  }

// Function to display an alert dialog
  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> checkFavoriteStatus() async {
    final request = context.read<CookieRequest>();

    try {
      // Make a GET request to the API endpoint
      final response = await request.postJson(
        'https://tajri.raisyam.my.id/book/is-favorite/$idBuku/',
        jsonEncode(<String, dynamic>{}),
      );

      // Parse the response JSON

      // Update the state based on the response

      setState(() {
        if (response['status'] == 'success') {
          // set isFavorited to true if the book is a favorite
          isFavorited = true;
        } else {
          isFavorited = false;
        }
      });
    } catch (error) {
      // Handle errors, e.g., if the request fails
      print('Error checking favorite status: $error');
    }
  }

  String get judulBuku => widget.book.fields.title;
  String get deskripsiBuku => widget.book.fields.description;
  String get urlCover => widget.book.fields.images;
  String get tahunTerbit => widget.book.fields.year.toString();
  String get penerbit => widget.book.fields.publisher;
  String get isbn => widget.book.fields.isbn;
  String get penulisBuku => widget.book.fields.author;

  @override
  void initState() {
    super.initState();
    // Call the API to check whether the book is a favorite or not
    checkFavoriteStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReview();
  }

  @override
  Widget build(BuildContext context) {
    Widget coverBuku() {
      return Container(
          height: 250,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.network(urlCover).image,
            ),
          ));
    }

    Widget footer() {
      return SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 60,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: const Color(0xFF327957),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Simpan ke Rak Buku',
                          style: TextStyle(color: Color(0xFF327957))),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF327957),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle "Ingin Membaca"
                                addWantToRead();
                                Navigator.pop(context);
                              },
                              child: const Text('Ingin Membaca',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF327957),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle "Sedang Membaca"
                                addReading();
                                Navigator.pop(context);
                              },
                              child: const Text('Sedang Membaca',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF327957),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle "Sudah Dibaca"
                                addRead();
                                Navigator.pop(context);
                              },
                              child: const Text('Telah Dibaca',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text(
                'Simpan Buku',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )));
    }

    Widget favoritButton() {
      return Positioned(
        top: 275,
        right: 30,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Color(0xFF327957),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)]),
          child: IconButton(
            onPressed: () async {
              final request = context.read<CookieRequest>();

              // Toggle the isFavorited state
              setState(() {
                isFavorited = !isFavorited;
              });

              // Add or remove the book from favorites based on the isFavorited state
              try {
                if (isFavorited) {
                  await request.postJson(
                    'https://tajri.raisyam.my.id/book/add-favorite-flutter/$idBuku/',
                    jsonEncode(<String, dynamic>{}),
                  );
                } else {
                  await request.post(
                    'https://tajri.raisyam.my.id/user_registered/delete_favorite_flutter/$idBuku',
                    {},
                  );
                }

                // Show the favorit confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Berhasil!'),
                      content: Text(
                        'Buku telah ${isFavorited ? 'ditambahkan ke' : 'dihapus dari'} favorit.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } catch (error) {
                // Handle errors, e.g., if the request to add/remove from favorites fails
                print('Error updating favorite status: $error');
              }
            },
            icon: Icon(
              isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget infoDeskripsi() {
      return Container(
        height: 60,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
            color: Color(0xFFECF2F2),
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text('Tahun Terbit',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                const SizedBox(height: 2),
                Text(tahunTerbit,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
            const VerticalDivider(color: Colors.black, thickness: 1),
            Column(
              children: [
                const Text('Penerbit',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                const SizedBox(height: 2),
                Text(penerbit,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
            const VerticalDivider(color: Colors.black, thickness: 1),
            Column(
              children: [
                const Text('ISBN',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                const SizedBox(height: 2),
                Text(isbn,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      );
    }

    Widget review() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Review Buku',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF327957))),
            const SizedBox(height: 10),
            FutureBuilder<List<Reviews>>(
              future: fetchReview(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Reviews> reviews = snapshot.data!;

                  // Show only the two latest reviews
                  reviews =
                      reviews.length > 2 ? reviews.sublist(0, 2) : reviews;

                  return Column(
                    children: [
                      for (var index = 0; index < reviews.length; index++)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: const Color(0xFFECF2F2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    // Display the first letter of the username
                                    child: Center(
                                      child: Text(
                                        reviews[index].username[0],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reviews[index].username,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        reviews[index].waktu.toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF327957)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                reviews[index].review,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF327957)),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF327957),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AllReviews(bookId: widget.book.pk),
                                  ),
                                );
                              },
                              child: const Text('Lihat Semua Review',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF327957),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddReview(bookId: widget.book.pk),
                                  ),
                                );
                              },
                              child: const Text('Tambahkan Review',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                      margin: const EdgeInsets.only(top: 20),
                      // child text dan tombol tambahkan review
                      child: Column(
                        children: [
                          Text(
                            'Belum ada review',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF327957)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF327957),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AddReview(bookId: widget.book.pk),
                                ),
                              );
                            },
                            child: const Text('Tambahkan Review',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ));
                } else if (snapshot.hasData && snapshot.data!.length <= 2) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF327957),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddReview(bookId: widget.book.pk),
                          ),
                        );
                      },
                      child: const Text('Tambahkan Review',
                          style: TextStyle(color: Colors.white)),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      );
    }

    Widget deskripsi() {
      return Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 300),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        judulBuku,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(penulisBuku,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF327957)))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // kiriman data deskripsiBuku ke DeskripsiBuku()
                        builder: (context) =>
                            DeskripsiBuku(widget.book.fields.description)));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Deskripsi Buku',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Icon(Icons.arrow_right_rounded, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Column(
                children: [
                  Text(
                    deskripsiBuku,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF327957),
                    ),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            infoDeskripsi(),
            review(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF327957),
      appBar: AppBar(
        backgroundColor: const Color(0xFF327957),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded,
              size: 30, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Detail Buku",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              deskripsi(),
              Column(
                children: [
                  coverBuku(),
                ],
              ),
              favoritButton(),
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: footer(),
      ),
    );
  }
}
