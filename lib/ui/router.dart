import 'package:flutter/material.dart';
import 'package:todo_app/ui/splash_page.dart';
import 'package:todo_app/utils/const.dart';


class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return _navigateTo(view: const SplashPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

MaterialPageRoute _navigateTo({required Widget view}) {
  return MaterialPageRoute(builder: (_) => view);
}
