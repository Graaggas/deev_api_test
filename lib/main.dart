import 'package:deev_api_test/blocs/album_bloc/album_bloc.dart';
import 'package:deev_api_test/blocs/bloc/photo_bloc.dart';

import 'package:deev_api_test/blocs/comments_bloc/comments_bloc.dart';

import 'package:deev_api_test/blocs/post_bloc/post_bloc.dart';
import 'package:deev_api_test/blocs/user_bloc/user_bloc.dart';
import 'package:deev_api_test/misc/bloc_observer.dart';
import 'package:deev_api_test/misc/route_generator.dart';
import 'package:deev_api_test/repo/album_repo.dart';
import 'package:deev_api_test/repo/comment_repo.dart';
import 'package:deev_api_test/repo/photo_repo.dart';
import 'package:deev_api_test/repo/post_repo.dart';
import 'package:deev_api_test/repo/user_repo.dart';

import 'package:deev_api_test/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  // Bloc.observer = BlocCustomObserver();

  final UserRepo userRepo = UserRepo(
    apiClient: APIClient(httpClient: http.Client()),
  );

  // final PhotoRepo photoRepo = PhotoRepo(
  //   apiClient: APIClient(httpClient: http.Client()),
  // );

  final PostRepo postRepo =
      PostRepo(apiClient: APIClient(httpClient: http.Client()));

  final CommentRepo commentRepo =
      CommentRepo(apiClient: APIClient(httpClient: http.Client()));

  final AlbumRepo albumRepo =
      AlbumRepo(apiClient: APIClient(httpClient: http.Client()));

  runApp(
    MyApp(
      userRepo: userRepo,
      postRepo: postRepo,
      commentRepo: commentRepo,
      albumRepo: albumRepo,
      // photoRepo: photoRepo,
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepo userRepo;
  final PostRepo postRepo;
  final CommentRepo commentRepo;
  final AlbumRepo albumRepo;
  // final PhotoRepo photoRepo;

  MyApp({
    required this.userRepo,
    required this.postRepo,
    required this.commentRepo,
    required this.albumRepo,
    // required this.photoRepo,
  });

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
        BlocProvider(create: (context) => AlbumBloc(albumRepo: albumRepo)),
        // BlocProvider(create: (context) => PhotoBloc(photoRepo: photoRepo)),
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
