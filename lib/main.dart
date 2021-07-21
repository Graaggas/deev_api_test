import 'package:deev_api_test/blocs/commens_bloc/comments_bloc.dart';
import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:deev_api_test/blocs/user_bloc/user_bloc.dart';
import 'package:deev_api_test/misc/route_generator.dart';
import 'package:deev_api_test/repo/comment_repo.dart';
import 'package:deev_api_test/repo/post_repo.dart';
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

  final PostRepo postRepo =
      PostRepo(apiClient: APIClient(httpClient: http.Client()));

  final CommentRepo commentRepo =
      CommentRepo(apiClient: APIClient(httpClient: http.Client()));

  runApp(
    MyApp(
      userRepo: userRepo,
      postRepo: postRepo,
      commentRepo: commentRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo;
  final PostRepo postRepo;
  final CommentRepo commentRepo;

  MyApp(
      {required this.userRepo,
      required this.postRepo,
      required this.commentRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(userRepo: userRepo),
        ),
        BlocProvider(create: (context) => PostBloc(postRepo: postRepo)),
        BlocProvider(
          create: (context) => CommentsBloc(commentRepo: commentRepo),
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
