import 'package:equatable/equatable.dart';

class AlbumPhoto extends Equatable {
  final int userId;
  final int id;
  final String title;

  AlbumPhoto({required this.id, required this.title, required this.userId});

  factory AlbumPhoto.fromJson(Map<String, dynamic> json) => AlbumPhoto(
        id: json["id"],
        title: json["title"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userId": userId,
      };

  List<Object> get props => [
        id,
        userId,
        title,
      ];
}
