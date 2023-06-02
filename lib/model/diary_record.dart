// To parse this JSON data, do
//
//     final diaryRecord = diaryRecordFromJson(jsonString);

import 'dart:convert';

List<DiaryRecord> diaryRecordFromJson(String str) => List<DiaryRecord>.from(json.decode(str).map((x) => DiaryRecord.fromJson(x)));

String diaryRecordToJson(List<DiaryRecord> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiaryRecord {
    String model;
    int pk;
    Fields fields;

    DiaryRecord({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory DiaryRecord.fromJson(Map<String, dynamic> json) => DiaryRecord(
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
    DateTime date;
    String description;

    Fields({
        required this.date,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        date: DateTime.parse(json["date"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "description": description,
    };
}
