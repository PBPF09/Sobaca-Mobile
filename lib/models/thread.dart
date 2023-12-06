// To parse this JSON data, do
//
//     final thread = threadFromJson(jsonString);

import 'dart:convert';

List<Thread> threadFromJson(String str) => List<Thread>.from(json.decode(str).map((x) => Thread.fromJson(x)));

String threadToJson(List<Thread> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thread {
    Model model;
    int pk;
    Fields fields;

    Thread({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Thread.fromJson(Map<String, dynamic> json) => Thread(
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
    int book;
    int user;
    String title;
    String content;
    DateTime dateCreate;

    Fields({
        required this.book,
        required this.user,
        required this.title,
        required this.content,
        required this.dateCreate,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        book: json["book"],
        user: json["user"],
        title: json["title"],
        content: json["content"],
        dateCreate: DateTime.parse(json["date_create"]),
    );

    Map<String, dynamic> toJson() => {
        "book": book,
        "user": user,
        "title": title,
        "content": content,
        "date_create": dateCreate.toIso8601String(),
    };
}

enum Model {
    DISCUSSION_DISCUSSIONTHREAD
}

final modelValues = EnumValues({
    "discussion.discussionthread": Model.DISCUSSION_DISCUSSIONTHREAD
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
