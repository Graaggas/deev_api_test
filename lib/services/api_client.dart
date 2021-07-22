import 'dart:convert';

import 'package:deev_api_test/models/comment.dart';
import 'package:deev_api_test/models/post.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:http/http.dart' as http;

class APIClient {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client httpClient;

  APIClient({required this.httpClient});

  Future<List<User>> fetchUsers() async {
    final mainUrl = '$baseUrl/users';

    final usersResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (usersResponse.statusCode != 200) {
      throw Exception('error getting users');
    }

    List<User> usersList = (json.decode(usersResponse.body) as List)
        .map((e) => User.fromJson(e))
        .toList();

    return usersList;
  }

  Future<List<Post>> fetchPosts() async {
    final mainUrl = '$baseUrl/posts';

    final postsResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (postsResponse.statusCode != 200) {
      throw Exception("error getting posts");
    }

    List<Post> postList = (json.decode(postsResponse.body) as List)
        .map((e) => Post.fromJson(e))
        .toList();
    return postList;
  }

  Future<List<Comment>> fetchComments() async {
    final mainUrl = '$baseUrl/comments';

    final commentsResponse = await this.httpClient.get(Uri.parse(mainUrl));

    if (commentsResponse.statusCode != 200) {
      throw Exception("error getting comments");
    }

    List<Comment> commentsList = (json.decode(commentsResponse.body) as List)
        .map((e) => Comment.fromJson(e))
        .toList();
    return commentsList;
  }

  Future<bool> postComment(Comment comment) async {
    final mainUrl = '$baseUrl/comments';

    final postCommentResponse = await http.post(
      Uri.parse(mainUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(comment.toJson()),
    );

    if (postCommentResponse.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create comment.');
    }
  }
}
