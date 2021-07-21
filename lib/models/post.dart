import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        body: json["body"],
        id: json["id"],
        title: json["title"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "id": id,
        "title": title,
        "userId": userId,
      };

  List<Object> get props => [
        body,
        id,
        userId,
        title,
      ];
}
