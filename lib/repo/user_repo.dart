import 'dart:convert';

import 'package:deev_api_test/models/user.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final APIClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<List<User>> getUsers() async {
    print("==> USERREPO");

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("userId"))) {
      List<User> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("userId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          listFromShPref.add(User.fromJson(decoded));
        }
      });
      listFromShPref.sort((a, b) {
        return a.id.compareTo(b.id);
      });
      return listFromShPref;
    } else {
      var usersFromAPI = await apiClient.fetchUsers();

      usersFromAPI.forEach((element) async {
        String value = jsonEncode(element.toJson());
        String key = "userId:" + element.id.toString();

        await sharedPreferences.setString(key, value);
      });

      usersFromAPI.sort((a, b) {
        return a.id.compareTo(b.id);
      });
      return usersFromAPI;
    }
  }
}
