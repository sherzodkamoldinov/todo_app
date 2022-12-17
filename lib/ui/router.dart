import 'package:flutter/material.dart';
import 'package:todo_app/ui/auth/auth_page.dart';
import 'package:todo_app/ui/auth/login_page.dart';
import 'package:todo_app/ui/auth/register_page.dart';
import 'package:todo_app/ui/home_page/widgets/create_category_page.dart';
import 'package:todo_app/ui/on_boarding/on_boarding_page.dart';
import 'package:todo_app/ui/setting_page.dart';
import 'package:todo_app/ui/splash_page.dart';
import 'package:todo_app/ui/tab_box/tab_box.dart';
import 'package:todo_app/utils/const.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return _navigateTo(view: const SplashPage());
      case onBoardingPage:
        return _navigateTo(view: const OnBoardingPage());
      case authPage:
        return _navigateTo(view: const AuthPage());
      case loginPage:
        return _navigateTo(view: const LoginPage());
      case registerPage:
        return _navigateTo(view: const RegisterPage());
      case tabBox:
        return _navigateTo(view: const TabBox());
      case createCategoryPage:
        return _navigateTo(view: const CreateCategory());
      case settingsPage:
        return _navigateTo(view: const SettingsPage());
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
