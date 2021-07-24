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
    print("==> PhotoRepo, albumId=$albumId");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty) {
      // print("PHOTO FROM SH_PREF NOW: " + checkingDataFromSharedPref.toString());

      List<Photo> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("photoId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          print("data photo in sh_pref = " + decoded.values.toString());
          for (var item in decoded.entries) {
            if (item.key == "albumId" && item.value == albumId) {
              print("set to list: ${decoded.toString()}");
              listFromShPref.add(Photo.fromJson(decoded));
            }
          }
        }
      });

      if (listFromShPref.isEmpty) {
        List<Photo> list = await getPhotoListFromAPIAndSaveAtShPref(
            apiClient, albumId, sharedPreferences);

        print("photo list is empty");
        return getPhotoByUserIdFromBaseAndTranslateToUI(albumId, list);
      } else {
        print("photo list is not empty");
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
      print(
          "send photo to Bloc,  photoId: ${element.id.toString()}] for albumId $albumId");
    }
  });

  photoByUser.sort((a, b) {
    return a.id.compareTo(b.id);
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

  // print("POST FROM API: " + postsFromAPI.toString());
  return photoFromAPI;
}
