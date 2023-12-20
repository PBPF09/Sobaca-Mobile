import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sobaca_mobile/models/books.dart'; // Import your book model

class BookShelvesPage extends StatefulWidget {
  @override
  _BookShelvesPageState createState() => _BookShelvesPageState();
}

class _BookShelvesPageState extends State<BookShelvesPage> {
  // Define lists to store book data
  List<Book> wantToReadBooks = [];
  List<Book> readingBooks = [];
  List<Book> readBooks = [];

  Future<void> fetchBookData() async {
    try {
      final request = context.read<CookieRequest>();
      final response = await request
          .get('https://tajri.raisyam.my.id/book/get-user-book-data/');

      if (response['status'] == 'success') {
        for (var shelf in ['want_to_read']) {
          List<Book> shelfBooks = _parseBookData(response[shelf]);
          wantToReadBooks.addAll(shelfBooks);
        }
        for (var shelf in ['reading']) {
          List<Book> shelfBooks = _parseBookData(response[shelf]);
          readingBooks.addAll(shelfBooks);
        }
        for (var shelf in ['read']) {
          List<Book> shelfBooks = _parseBookData(response[shelf]);
          readBooks.addAll(shelfBooks);
        }
      } else {
        throw Exception('Failed to load book data1');
      }
    } catch (error) {
      print('Error fetching book data: $error');
    }
  }

// Helper function to parse book data
  List<Book> _parseBookData(List<dynamic> bookData) {
    return bookData
        .map((item) => Book(
              model: Model.BOOK_BOOK,
              pk: 0, // You can set this to any value, as it's not present in your JSON
              fields: Fields.fromJson(item),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // Fetch book data when the widget is initialized
    fetchBookData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch book data when the dependencies change (including context)
    // fetchBookData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Book Shelves'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Want to Read'),
              Tab(text: 'Reading'),
              Tab(text: 'Read'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ShelfTab(books: wantToReadBooks),
            ShelfTab(books: readingBooks),
            ShelfTab(books: readBooks),
          ],
        ),
      ),
    );
  }
}

class ShelfTab extends StatelessWidget {
  final List<Book> books;

  const ShelfTab({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookTile(book: book);
      },
    );
  }
}

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BookCover(imageUrl: book.fields.images),
      title: Text(book.fields.title),
      subtitle: Text(book.fields.author),
    );
  }
}

class BookCover extends StatelessWidget {
  final String imageUrl;

  const BookCover({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
