import 'dart:convert';

import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepo {
  final APIClient apiClient;

  PostRepo({
    required this.apiClient,
  });

  Future<List<Post>> getPosts(int id) async {
    print("==> POSTREPO");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("postId"))) {
      // print("FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<Post> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("postId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          listFromShPref.add(Post.fromJson(decoded));
          // print("~added post from sh_pref ${Post.fromJson(decoded).title}");
        }
      });

      return getPostsByUserId(id, listFromShPref);
    } else {
      var postsFromAPI = await apiClient.fetchPosts();

      postsFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "postId:" + element.id.toString();

        await sharedPreferences.setString(key, value);
      });

      // print("POST FROM API: " + postsFromAPI.toString());

      return getPostsByUserId(id, postsFromAPI);
    }
  }
}

List<Post> getPostsByUserId(int id, List<Post> listFromBase) {
  List<Post> postByUser = [];

  listFromBase.forEach((element) {
    if (element.userId == id) {
      postByUser.add(element);
      // print(
      //     "Post title [userId: ${element.userId.toString()}]: ${element.title}");
    }
  });

  return postByUser;
}
