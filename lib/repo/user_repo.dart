import 'dart:convert';

import 'package:deev_api_test/models/user.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final APIClient apiClient;

  UserRepo({
    required this.apiClient,
  });

  Future<List<User>> getUsers() async {
    print("==> USERREPO");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    //? checking data at sh_pref
    Set<String>? checkingDataFromSharedPref = sharedPreferences.getKeys();

    if (checkingDataFromSharedPref.isNotEmpty &&
        checkingDataFromSharedPref
            .any((element) => element.contains("userId"))) {
      // print("FROM SH_PREF: " + checkingDataFromSharedPref.toString());

      List<User> listFromShPref = [];

      checkingDataFromSharedPref.forEach((element) {
        if (element.contains("userId")) {
          String? res = sharedPreferences.getString(element);
          Map<String, dynamic> decoded = jsonDecode(res!);
          // print("data in sh_pref = " + decoded.values.toString());
          listFromShPref.add(User.fromJson(decoded));
          // print("~added user from sh_pref: ${User.fromJson(decoded).name}");
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

      // print("USER FROM API: " + usersFromAPI.toString());
      usersFromAPI.sort((a, b) {
        return a.id.compareTo(b.id);
      });
      return usersFromAPI;
    }
  }
}
