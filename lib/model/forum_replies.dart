// To parse this JSON data, do
//
//     final replies = repliesFromJson(jsonString);

import 'dart:convert';

List<Replies> repliesFromJson(String str) => List<Replies>.from(json.decode(str).map((x) => Replies.fromJson(x)));

String repliesToJson(List<Replies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Replies {
    String model;
    int pk;
    Fields fields;

    Replies({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Replies.fromJson(Map<String, dynamic> json) => Replies(
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
    String username;
    int post;
    DateTime date;
    String content;

    Fields({
        required this.user,
        required this.username,
        required this.post,
        required this.date,
        required this.content,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        post: json["post"],
        date: DateTime.parse(json["date"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "post": post,
        "date": date.toIso8601String(),
        "content": content,
    };
}
