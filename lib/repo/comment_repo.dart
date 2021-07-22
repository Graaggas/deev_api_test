import 'dart:convert';

import 'package:deev_api_test/models/comment.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentRepo {
  final APIClient apiClient;

  CommentRepo({
    required this.apiClient,
  });

  Future<void> postComment(Comment comment) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var flagCreateCommentSuccess = await apiClient.postComment(comment);
    print("posting in api server: ${flagCreateCommentSuccess.toString()}");

    String value = jsonEncode(comment.toJson());
    String key = "commentId:" + comment.id.toString();

    await sharedPreferences.setString(key, value);
  }

  Future<List<Comment>> getComments(int postId) async {
    print("==> COMMENTREPO");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("commentId"))) {
      // print("FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<Comment> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("commentId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          listFromShPref.add(Comment.fromJson(decoded));
          // print(
          //     "~added comment from sh_pref ${Comment.fromJson(decoded).name}");
        }
      });

      return getCommentsByPostId(postId, listFromShPref);
    } else {
      var commentsFromAPI = await apiClient.fetchComments();

      commentsFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "commentId:" + element.id.toString();

        await sharedPreferences.setString(key, value);
      });

      // print("POST FROM API: " + commentsFromAPI.toString());

      return getCommentsByPostId(postId, commentsFromAPI);
    }
  }
}

List<Comment> getCommentsByPostId(int id, List<Comment> listFromBase) {
  List<Comment> commentsByPost = [];

  listFromBase.forEach((element) {
    if (element.postId == id) {
      commentsByPost.add(element);
      // print(
      //     "Comment [postid: ${element.postId.toString()}]: ${element.id}: ${element.name}");
    }
  });

  return commentsByPost;
}
