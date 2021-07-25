import 'dart:convert';

import 'package:deev_api_test/models/photo.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoRepo {
  final APIClient apiClient;

  PhotoRepo({
    required this.apiClient,
  });

  Future<List<Photo>> getPhoto(int albumId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty) {
      List<Photo> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("photoId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          for (var item in decoded.entries) {
            if (item.key == "albumId" && item.value == albumId) {
              listFromShPref.add(Photo.fromJson(decoded));
            }
          }
        }
      });

      if (listFromShPref.isEmpty) {
        List<Photo> list = await getPhotoListFromAPIAndSaveAtShPref(
            apiClient, albumId, sharedPreferences);

        return getPhotoByUserIdFromBaseAndTranslateToUI(albumId, list);
      } else {
        return getPhotoByUserIdFromBaseAndTranslateToUI(
            albumId, listFromShPref);
      }
    } else {
      List<Photo> list = await getPhotoListFromAPIAndSaveAtShPref(
          apiClient, albumId, sharedPreferences);
      return getPhotoByUserIdFromBaseAndTranslateToUI(albumId, list);
    }
  }
}

List<Photo> getPhotoByUserIdFromBaseAndTranslateToUI(
    int albumId, List<Photo> listFromBase) {
  List<Photo> photoByUser = [];

  listFromBase.forEach((element) {
    if (element.albumId == albumId) {
      photoByUser.add(element);
    }
  });

  return photoByUser;
}

Future<List<Photo>> getPhotoListFromAPIAndSaveAtShPref(
    APIClient apiClient, int id, SharedPreferences sharedPreferences) async {
  var photoFromAPI = await apiClient.fetchPhotos(id);

  photoFromAPI.forEach((element) async {
    String value = jsonEncode(element.toJson());
    String key = "photoId:" + element.id.toString();

    await sharedPreferences.setString(key, value);
  });

  return photoFromAPI;
}
