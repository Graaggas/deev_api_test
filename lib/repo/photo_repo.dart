import 'dart:convert';

import 'package:deev_api_test/models/photo.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoRepo {
  final APIClient apiClient;

  PhotoRepo({
    required this.apiClient,
  });

  Future<List<Photo>> getPhotos(int albumId) async {
    print("==> PHOTOREPO");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("photoId"))) {
      List<Photo> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("photoId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          listFromShPref.add(Photo.fromJson(decoded));
        }
      });

      return getPhotosByPostId(albumId, listFromShPref);
    } else {
      var photosFromAPI = await apiClient.fetchPhotos();

      photosFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "photoId:" + element.id.toString();
        await sharedPreferences.setString(key, value);
      });

      return getPhotosByPostId(albumId, photosFromAPI);
    }
  }
}

List<Photo> getPhotosByPostId(int id, List<Photo> listFromBase) {
  List<Photo> photosByPost = [];

  listFromBase.forEach((element) {
    if (element.albumId == id) {
      photosByPost.add(element);
      print(
          "Photo [photoId: ${element.albumId.toString()}]: ${element.id}: ${element.title}");
    }
  });

  return photosByPost;
}
