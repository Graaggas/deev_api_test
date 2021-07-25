import 'dart:convert';

import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepo {
  final APIClient apiClient;
  final SharedPreferences sharedPreferences;

  PostRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<List<Post>> getPosts(int userId) async {
    print("==> POSTREPO, userId = $userId");

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty) {
      List<Post> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("postId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          for (var item in decoded.entries) {
            if (item.key == "userId" && item.value == userId) {
              listFromShPref.add(Post.fromJson(decoded));
            }
          }
        }
      });

      if (listFromShPref.isEmpty) {
        List<Post> list = await getPostListFromAPIAndSaveAtShPref(
            apiClient, userId, sharedPreferences);

        return getPostsByUserIdFromBaseAndTranslateToUI(userId, list);
      } else {
        return getPostsByUserIdFromBaseAndTranslateToUI(userId, listFromShPref);
      }
    } else {
      List<Post> list = await getPostListFromAPIAndSaveAtShPref(
          apiClient, userId, sharedPreferences);

      return getPostsByUserIdFromBaseAndTranslateToUI(userId, list);
    }
  }
}

List<Post> getPostsByUserIdFromBaseAndTranslateToUI(
    int id, List<Post> listFromBase) {
  List<Post> postByUser = [];

  listFromBase.forEach((element) {
    if (element.userId == id) {
      postByUser.add(element);
    }
  });

  postByUser.sort((a, b) {
    return a.id.compareTo(b.id);
  });
  return postByUser;
}

Future<List<Post>> getPostListFromAPIAndSaveAtShPref(
    APIClient apiClient, int id, SharedPreferences sharedPreferences) async {
  var postsFromAPI = await apiClient.fetchPosts(id);

  postsFromAPI.forEach((element) async {
    String value = jsonEncode(element.toJson());
    String key = "postId:" + element.id.toString();

    await sharedPreferences.setString(key, value);
  });

  return postsFromAPI;
}
