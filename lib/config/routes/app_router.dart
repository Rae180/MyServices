import 'package:flutter/material.dart';
import 'package:start/features/home/view/screen/Auth.dart';
import 'package:start/core/managers/string_manager.dart';
import 'package:start/features/home/view/screen/Signup_Screen.dart';
import 'package:start/features/home/view/screen/Signup_Screen_Provider.dart';
import 'package:start/features/home/view/screen/Welcome_screen.dart';
import 'package:start/features/home/view/screen/home.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case WelcomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case SignupScreen.routeName:
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case SignupScreenProvider.routeName:
        return MaterialPageRoute(builder: (context) => SignupScreenProvider());
        

      default:
        return unDefinedRoute();
    }
  }

  Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
