import 'package:deev_api_test/models/user.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
      ),
      body: Center(
        child: Text(user.name),
      ),
    );
  }
}
