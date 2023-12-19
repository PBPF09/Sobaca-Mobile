// To parse this JSON data, do
//
//     final thread = threadFromJson(jsonString);

import 'dart:convert';

List<Thread> threadFromJson(String str) => List<Thread>.from(json.decode(str).map((x) => Thread.fromJson(x)));

String threadToJson(List<Thread> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thread {
    int id;
    String user;
    bool isAuthor;
    String title;
    String content;
    DateTime dateCreate;
    Book book;

    Thread({
        required this.id,
        required this.user,
        required this.isAuthor,
        required this.title,
        required this.content,
        required this.dateCreate,
        required this.book,
    });

    factory Thread.fromJson(Map<String, dynamic> json) => Thread(
        id: json["id"],
        user: json["user"],
        isAuthor: json["is_author"],
        title: json["title"],
        content: json["content"],
        dateCreate: DateTime.parse(json["date_create"]),
        book: Book.fromJson(json["book"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "is_author": isAuthor,
        "title": title,
        "content": content,
        "date_create": dateCreate.toIso8601String(),
        "book": book.toJson(),
    };
}

class Book {
    String isbn;
    String title;
    String author;
    int year;
    String publisher;
    String description;
    String image;

  var pk;

    Book({
        required this.isbn,
        required this.title,
        required this.author,
        required this.year,
        required this.publisher,
        required this.description,
        required this.image,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        isbn: json["isbn"],
        title: json["title"],
        author: json["author"],
        year: json["year"],
        publisher: json["publisher"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "author": author,
        "year": year,
        "publisher": publisher,
        "description": description,
        "image": image,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
