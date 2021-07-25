import 'package:deev_api_test/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FadeInImage.memoryNetwork(
          width: double.infinity,
          fit: BoxFit.fitWidth,
          placeholder: kTransparentImage,
          image: photo.url),
    );
  }
}
