import 'dart:convert';

List<Book> itemFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String itemToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String isbn;
    String title;
    String categories;
    String author;
    int year;
    String publisher;
    String description;
    String images;

    Fields({
        required this.isbn,
        required this.title,
        required this.categories,
        required this.author,
        required this.year,
        required this.publisher,
        required this.description,
        required this.images,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        categories: json["categories"],
        author: json["author"],
        year: json["year"],
        publisher: json["publisher"],
        description: json["description"],
        images: json["images"],
    );

    Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "categories": categories,
        "author": author,
        "year": year,
        "publisher": publisher,
        "description": description,
        "images": images,
    };
}

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}