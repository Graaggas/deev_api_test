import 'dart:convert';

import 'package:deev_api_test/models/comment.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentRepo {
  final APIClient apiClient;
  final SharedPreferences sharedPreferences;

  CommentRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<void> postComment(Comment comment) async {
    var flagCreateCommentSuccess = await apiClient.postComment(comment);
    print("posting in api server: ${flagCreateCommentSuccess.toString()}");

    String value = jsonEncode(comment.toJson());
    String key = "commentId:" + comment.id.toString();

    await sharedPreferences.setString(key, value);
  }

  Future<List<Comment>> getComments(int postId) async {
    print("==> COMMENTREPO, postId = $postId");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty) {
      // print("COMMENTS FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<Comment> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("commentId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          for (var item in decoded.entries) {
            if (item.key == "postId" && item.value == postId) {
              listFromShPref.add(Comment.fromJson(decoded));
            }
          }
        }
      });

      if (listFromShPref.isEmpty) {
        List<Comment> list = await getCommentListFromAPIAndSaveAtShPref(
            apiClient, postId, sharedPreferences);

        return getCommentsByPostIdFromBaseAndTranslateToUI(postId, list);
      } else {
        return getCommentsByPostIdFromBaseAndTranslateToUI(
            postId, listFromShPref);
      }
    } else {
      var commentsFromAPI = await apiClient.fetchComments(postId);

      commentsFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "commentId:" + element.id.toString();

        await sharedPreferences.setString(key, value);
      });

      print("COMMENTS FROM API: " + commentsFromAPI.toString());

      return getCommentsByPostIdFromBaseAndTranslateToUI(
          postId, commentsFromAPI);
    }
  }
}

List<Comment> getCommentsByPostIdFromBaseAndTranslateToUI(
    int id, List<Comment> listFromBase) {
  List<Comment> commentsByPost = [];

  listFromBase.forEach((element) {
    if (element.postId == id) {
      commentsByPost.add(element);
    }
  });

  commentsByPost.sort((a, b) {
    return a.id.compareTo(b.id);
  });
  return commentsByPost;
}

Future<List<Comment>> getCommentListFromAPIAndSaveAtShPref(
    APIClient apiClient, int id, SharedPreferences sharedPreferences) async {
  var commentFromAPI = await apiClient.fetchComments(id);

  commentFromAPI.forEach((element) async {
    String value = jsonEncode(element.toJson());
    String key = "commentId:" + element.id.toString();

    await sharedPreferences.setString(key, value);
  });

  // print("POST FROM API: " + postsFromAPI.toString());
  return commentFromAPI;
}
