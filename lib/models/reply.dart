import 'dart:convert';

List<Reply> replyFromJson(String str) => List<Reply>.from(json.decode(str).map((x) => Reply.fromJson(x)));

String replyToJson(List<Reply> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reply {
    Model model;
    int pk;
    Fields fields;

    Reply({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Reply.fromJson(Map<String, dynamic> json) => Reply(
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
    int thread;
    int user;
    String content;
    DateTime dateCreate;

    Fields({
        required this.thread,
        required this.user,
        required this.content,
        required this.dateCreate,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        thread: json["thread"],
        user: json["user"],
        content: json["content"],
        dateCreate: DateTime.parse(json["date_create"]),
    );

    Map<String, dynamic> toJson() => {
        "thread": thread,
        "user": user,
        "content": content,
        "date_create": dateCreate.toIso8601String(),
    };
}

enum Model {
    DISCUSSION_DISCUSSIONREPLY
}

final modelValues = EnumValues({
    "discussion.discussionreply": Model.DISCUSSION_DISCUSSIONREPLY
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
