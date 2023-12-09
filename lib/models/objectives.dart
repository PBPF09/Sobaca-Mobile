// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Objective> productFromJson(String str) => List<Objective>.from(json.decode(str).map((x) => Objective.fromJson(x)));

String objectiveToJson(List<Objective> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Objective {
    String model;
    int pk;
    Fields fields;

    Objective({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Objective.fromJson(Map<String, dynamic> json) => Objective(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String title;
    String description;
    bool isCompleted;

    Fields({
        required this.user,
        required this.title,
        required this.description,
        required this.isCompleted,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
    };
}
