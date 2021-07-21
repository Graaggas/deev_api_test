import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        body: json["body"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
        postId: json["postId"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "email": email,
        "id": id,
        "name": name,
        "postId": postId,
      };

  @override
  List<Object> get props => [
        body,
        id,
        postId,
        name,
        email,
      ];
}
