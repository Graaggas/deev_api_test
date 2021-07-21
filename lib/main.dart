import 'package:deev_api_test/blocs/user_bloc/user_bloc.dart';
import 'package:deev_api_test/misc/route_generator.dart';
import 'package:deev_api_test/repo/user_repo.dart';
import 'package:deev_api_test/screens/main_screen.dart';
import 'package:deev_api_test/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final UserRepo userRepo = UserRepo(
    apiClient: APIClient(httpClient: http.Client()),
  );

  runApp(
    MyApp(
      userRepo: userRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo;

  MyApp({required this.userRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userRepo: userRepo),
        ),
      ],
      child: MaterialApp(
        title: 'API Demo by Deev Vladimir',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
