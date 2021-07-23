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

  Future<List<AlbumPhoto>> getAlbumForUser(int userId) async {
    print("==> ALBUMREPO/ForUser");

    List<AlbumPhoto> listFromShPref = [];

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();
    checkingDataFromSharedPref.forEach((element) {
      if (element.contains("albumId")) {
        String? res = sharedPreferences.getString(element);
        Map<String, dynamic> decoded = jsonDecode(res!);
        // print("data in sh_pref = " + decoded.values.toString());
        listFromShPref.add(AlbumPhoto.fromJson(decoded));
      }
    });

    return getAlbumsByUserId(userId, listFromShPref);
  }

  Future<List<AlbumPhoto>> getAlbums(int userId) async {
    print("==> ALBUMREPO");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("albumId"))) {
      // print("ALBUM FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<AlbumPhoto> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("albumId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          // print("data in sh_pref = " + decoded.values.toString());
          listFromShPref.add(AlbumPhoto.fromJson(decoded));
          // print(
          //     "~added album from sh_pref: ${AlbumPhoto.fromJson(decoded).title}");
        }
      });

      return listFromShPref;
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

List<AlbumPhoto> getAlbumsByUserId(int userId, List<AlbumPhoto> listFromBase) {
  List<AlbumPhoto> AlbumByUser = [];

  listFromBase.forEach((element) {
    if (element.userId == userId) {
      AlbumByUser.add(element);
      // print(
      //     "Post title [userId: ${element.userId.toString()}]: ${element.title}");
    }
  });

  return AlbumByUser;
}
