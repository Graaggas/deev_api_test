import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbNailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.thumbNailUrl,
    required this.title,
    required this.url,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        albumId: json["albumId"],
        id: json["id"],
        thumbNailUrl: json["thumbnailUrl"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "thumbnailUrl": thumbNailUrl,
        "title": title,
        "url": url,
      };

  List<Object> get props => [
        albumId,
        id,
        title,
        url,
        thumbNailUrl,
      ];
}
