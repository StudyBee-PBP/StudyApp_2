// To parse this JSON data, do
//
//     final studyPlan = studyPlanFromJson(jsonString);

import 'dart:convert';

List<StudyPlan> studyPlanFromJson(String str) => List<StudyPlan>.from(json.decode(str).map((x) => StudyPlan.fromJson(x)));

String studyPlanToJson(List<StudyPlan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyPlan {
    String model;
    int pk;
    Fields fields;

    StudyPlan({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory StudyPlan.fromJson(Map<String, dynamic> json) => StudyPlan(
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
    String name;
    String type;
    String subject;
    DateTime date;
    String location;
    String description;

    Fields({
        required this.name,
        required this.type,
        required this.subject,
        required this.date,
        required this.location,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        type: json["type"],
        subject: json["subject"],
        date: DateTime.parse(json["date"]),
        location: json["location"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "subject": subject,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "location": location,
        "description": description,
    };
}