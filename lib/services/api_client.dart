import 'dart:convert';

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
      throw Exception('error getting characters');
    }

    List<User> usersList = (json.decode(usersResponse.body) as List)
        .map((e) => User.fromJson(e))
        .toList();

    return usersList;
  }
}
