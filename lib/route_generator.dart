import 'package:flutter/material.dart';
import 'package:vietnam_tourist/models/post.dart';
import 'package:vietnam_tourist/screens/landing.dart';
import 'package:vietnam_tourist/screens/main_screen.dart';
import 'package:vietnam_tourist/screens/placename_details.dart';
import 'package:vietnam_tourist/screens/post_detail.dart';
import 'package:vietnam_tourist/screens/search.dart';
import 'package:vietnam_tourist/screens/tabs/create_post.dart';

import 'models/placename.dart';
import 'screens/new_placename.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Landing());
      case '/main_screen':
        return MaterialPageRoute(builder: (_) => TabScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => Search());
      case '/add_placename':
        return MaterialPageRoute(builder: (_) => NewPlacename());
      case '/placenamedetail':
        // Validation of correct data type
        if (args is Placename) {
          return MaterialPageRoute(
            builder: (_) => PlacenameDetail(
              placename: args,
            ),
          );
        }
        return _errorRoute();
      case '/postdetail':
        // Validation of correct data type
        if (args is Post) {
          return MaterialPageRoute(
            builder: (_) => PostDetail(
              post: args,
            ),
          );
        }

        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case '/creter_post':
        return MaterialPageRoute(builder: (_) => const CreatePost());
      default:
        // If there is no such named route in the switch statement, e.g. /third
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
