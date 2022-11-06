import 'dart:convert';

Doctors articlesFromJson(String str) => Doctors.fromJson(json.decode(str));

String articlesToJson(Doctors data) => json.encode(data.toJson());

class Doctors {
  Doctors({
    required this.id,
    required this.url,
    required this.topic,
    required this.description,
  });
  String id;
  String topic;
  String description;
  String url;

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
        id: json["id"] ?? "",
        topic: json["topic"] ?? "",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "description": description,
        "url": url,
      };
}
