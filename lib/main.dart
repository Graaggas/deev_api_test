import 'package:deev_api_test/blocs/album_bloc/album_bloc.dart';
import 'package:deev_api_test/blocs/bloc/photo_bloc.dart';

import 'package:deev_api_test/blocs/comments_bloc/comments_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Bloc.observer = BlocCustomObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final UserRepo userRepo = UserRepo(
    apiClient: APIClient(httpClient: http.Client()),
    sharedPreferences: sharedPreferences,
  );

  // final PhotoRepo photoRepo = PhotoRepo(
  //   apiClient: APIClient(httpClient: http.Client()),
  // );

  final PostRepo postRepo = PostRepo(
    apiClient: APIClient(httpClient: http.Client()),
    sharedPreferences: sharedPreferences,
  );

  final CommentRepo commentRepo = CommentRepo(
    apiClient: APIClient(httpClient: http.Client()),
    sharedPreferences: sharedPreferences,
  );

  final AlbumRepo albumRepo = AlbumRepo(
    apiClient: APIClient(httpClient: http.Client()),
    sharedPreferences: sharedPreferences,
  );

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
          textTheme: GoogleFonts.actorTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
