import 'package:flutter/material.dart';
import 'package:start/features/Auth/view/screens/Auth.dart';
import 'package:start/core/managers/string_manager.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen_Provider.dart';
import 'package:start/features/app_wrapper/app_wrapper.dart';
import 'package:start/features/user/Orders/view/widgets/orders_ot_accepted_yet.dart';
import 'package:start/features/user/Providers/view/Screen/Providers_Screen.dart';
import 'package:start/features/user/home/view/screen/Services_scree.dart';
import 'package:start/features/user/home/view/screen/Welcome_screen.dart';
import 'package:start/features/user/home/view/screen/home.dart';
import 'package:start/features/provider/home_provider/view/screens/home_provider_screen.dart';
import 'package:start/features/user/order_details/view/screen/order_details_screen.dart';

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
      case ProvidersScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProvidersScreen());
      case OrderDetailsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OrderDetailsScreen(),
          settings: routeSettings,
        );

      case ServicesScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ServicesScreen());
      case NotAcceptedYetOrders.routeName:
        return MaterialPageRoute(builder: (context) => const NotAcceptedYetOrders());
      
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
