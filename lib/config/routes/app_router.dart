import 'package:flutter/material.dart';
import 'package:start/features/Auth/view/screens/Auth.dart';
import 'package:start/core/managers/string_manager.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen_Provider.dart';
import 'package:start/features/app_wrapper/app_wrapper.dart';
import 'package:start/features/provider/order/view/screens/order_details_screen.dart';
import 'package:start/features/user/home/view/screen/Welcome_screen.dart';
import 'package:start/features/user/home/view/screen/home.dart';
import 'package:start/features/provider/home_provider/view/screens/home_provider_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case WelcomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case SignupScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case SignupScreenProvider.routeName:
        return MaterialPageRoute(
            builder: (context) => const SignupScreenProvider());
      case HomeProviderPage.routeName:
        return MaterialPageRoute(
            builder: (context) => const HomeProviderPage());
      case AppWrapper.routeName:
        return MaterialPageRoute(builder: (context) => const AppWrapper());
      case OrderDetailsScreen.routeName:
        final args = routeSettings.arguments as Map<String, dynamic>;
        int id = int.parse(args['id']);
        return MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                  id: id,
                ));

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
