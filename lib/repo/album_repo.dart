import 'dart:convert';

import 'package:deev_api_test/models/album.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumRepo {
  final APIClient apiClient;

  AlbumRepo({
    required this.apiClient,
  });

  Future<List<AlbumPhoto>> getAlbums(int userId) async {
    print("==> ALBUMREPO, userId=$userId");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty) {
      // print("ALBUM FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<AlbumPhoto> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("albumId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          // print("data in sh_pref = " + decoded.values.toString());
          for (var item in decoded.entries) {
            if (item.key == "userId" && item.value == userId) {
              listFromShPref.add(AlbumPhoto.fromJson(decoded));
            }
          }
        }
      });

      if (listFromShPref.isEmpty) {
        List<AlbumPhoto> list = await getAlbumListFromAPIAndSaveAtShPref(
            apiClient, userId, sharedPreferences);

        return getAlbumsByUserIdFromBaseAndTranslateToUI(userId, list);
      } else {
        return getAlbumsByUserIdFromBaseAndTranslateToUI(
            userId, listFromShPref);
      }
    } else {
      var albumsFromAPI = await apiClient.fetchAlbums(userId);

      albumsFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "albumId:" + element.id.toString();

        await sharedPreferences.setString(key, value);
      });

      // print("USER FROM API: " + usersFromAPI.toString());

      return albumsFromAPI;
    }
  }
}

List<AlbumPhoto> getAlbumsByUserIdFromBaseAndTranslateToUI(
    int userId, List<AlbumPhoto> listFromBase) {
  List<AlbumPhoto> albumByUser = [];

  listFromBase.forEach((element) {
    if (element.userId == userId) {
      albumByUser.add(element);
      // print(
      //     "Post title [userId: ${element.userId.toString()}]: ${element.title}");
    }
  });

  albumByUser.sort((a, b) {
    return a.id.compareTo(b.id);
  });
  return albumByUser;
}

Future<List<AlbumPhoto>> getAlbumListFromAPIAndSaveAtShPref(
    APIClient apiClient, int id, SharedPreferences sharedPreferences) async {
  var albumFromAPI = await apiClient.fetchAlbums(id);

  albumFromAPI.forEach((element) async {
    String value = jsonEncode(element.toJson());
    String key = "albumId:" + element.id.toString();

    await sharedPreferences.setString(key, value);
  });

  // print("POST FROM API: " + postsFromAPI.toString());
  return albumFromAPI;
}
