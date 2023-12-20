// To parse this JSON data, do
//
//     final reply = replyFromJson(jsonString);

import 'dart:convert';

List<Reply> replyFromJson(String str) => List<Reply>.from(json.decode(str).map((x) => Reply.fromJson(x)));

String replyToJson(List<Reply> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reply {
    int id;
    String content;
    String user;
    DateTime dateCreate;
    bool isAuthor;
    ThreadDetail thread;

    Reply({
        required this.id,
        required this.content,
        required this.user,
        required this.dateCreate,
        required this.isAuthor,
        required this.thread,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        content: json["content"],
        user: json["user"],
        dateCreate: DateTime.parse(json["date_create"]),
        isAuthor: json["is_author"],
        thread: ThreadDetail.fromJson(json["thread"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "user": user,
        "date_create": dateCreate.toIso8601String(),
        "is_author": isAuthor,
        "thread": thread.toJson(),
    };
}

class ThreadDetail {
    String title;
    String content;
    String user;
    DateTime dateCreate;

    ThreadDetail({
        required this.title,
        required this.content,
        required this.user,
        required this.dateCreate,
    });

    factory ThreadDetail.fromJson(Map<String, dynamic> json) => ThreadDetail(
        title: json["title"],
        content: json["content"],
        user: json["user"],
        dateCreate: DateTime.parse(json["date_create"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "user": user,
        "date_create": dateCreate.toIso8601String(),
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
