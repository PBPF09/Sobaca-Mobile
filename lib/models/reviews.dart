// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

List<Reviews> reviewsFromJson(String str) => List<Reviews>.from(json.decode(str).map((x) => Reviews.fromJson(x)));

String reviewsToJson(List<Reviews> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reviews {
    int reviewId;
    int userId;
    String username;
    int book;
    String review;
    DateTime waktu;

    Reviews({
        required this.reviewId,
        required this.userId,
        required this.username,
        required this.book,
        required this.review,
        required this.waktu,
    });

    factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        reviewId: json["review_id"],
        userId: json["user_id"],
        username: json["username"],
        book: json["book"],
        review: json["review"],
        waktu: DateTime.parse(json["waktu"]),
    );

    Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "user_id": userId,
        "username": username,
        "book": book,
        "review": review,
        "waktu": waktu.toIso8601String(),
    };
}
