// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    String model;
    int pk;
    Fields fields;

    Post({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
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
    dynamic user;
    dynamic username;
    DateTime date;
    String title;
    String content;

    Fields({
        this.user,
        this.username,
        required this.date,
        required this.title,
        required this.content,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        username: json["username"],
        date: DateTime.parse(json["date"]),
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "username": username,
        "date": date.toIso8601String(),
        "title": title,
        "content": content,
    };
}
