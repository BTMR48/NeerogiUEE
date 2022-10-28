import 'dart:convert';

Articles articlesFromJson(String str) => Articles.fromJson(json.decode(str));

String articlesToJson(Articles data) => json.encode(data.toJson());

class Articles {
  Articles({
    required this.id,
    required this.url,
    required this.topic,
    required this.description,
  });
  String id;
  String topic;
  String description;
  String url;

  factory Articles.fromJson(Map<String, dynamic> json) => Articles(
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
