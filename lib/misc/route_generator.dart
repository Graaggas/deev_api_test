import 'package:deev_api_test/models/album.dart';
import 'package:deev_api_test/models/photo.dart';
import 'package:deev_api_test/models/user.dart';
import 'package:deev_api_test/screens/albums_screen.dart';
import 'package:deev_api_test/screens/create_comment.dart';
import 'package:deev_api_test/screens/main_screen.dart';
import 'package:deev_api_test/screens/opened_post_screen.dart';
import 'package:deev_api_test/screens/photo_slider.dart';
import 'package:deev_api_test/screens/posts_page.dart';
import 'package:deev_api_test/screens/user_details_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainScreen());

      case '/photo_slider':
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => PhotoSlider(
                    albumId: args,
                  ));
        }

        return _errorRoute();

      case '/user_details_screen':
        if (args is User) {
          return MaterialPageRoute(
            builder: (_) => UserDetailsScreen(user: args),
          );
        }
        return _errorRoute();

      case '/posts_page_screen':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => PostsPage(userId: args),
          );
        }

        return _errorRoute();

      case '/albums_screen':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => AlbumsScreen(userId: args),
          );
        }

        return _errorRoute();

      case '/opened_post_screen':
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => OpenedPostScreen(postId: args),
          );
        }

        return _errorRoute();

      case '/create_comment_screen':
        if (args is int) {
          return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => CreateCommentPage(postId: args),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
