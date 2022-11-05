import 'dart:convert';

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));

String articlesToJson(Questions data) => json.encode(data.toJson());

class Questions {
  Questions({
    required this.id,
    required this.question,
  });
  String id;
  String question;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        id: json["id"] ?? "",
        question: json["question"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
      };
}
