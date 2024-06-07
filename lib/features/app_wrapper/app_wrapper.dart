import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/features/Auth/bloc/auth_bloc.dart';
import 'package:start/features/Auth/view/screens/Auth.dart';
import 'package:start/features/user/home/view/screen/Welcome_screen.dart';
import 'package:start/features/user/home/view/screen/home.dart';
import 'package:start/features/provider/home_provider/view/screens/home_provider_screen.dart';
import 'package:start/features/provider/home_provider/view/screens/waiting_active_provider_screen.dart';

class AppWrapper extends StatelessWidget {
  static const routeName = 'wrapper_scrren';

  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return _buildAuthBuilder(state, context);
      },
    );
  }

  Widget _buildAuthBuilder(AuthState state, BuildContext context) {
    if (state is AuthInitial) {
      return const WelcomeScreen();
    } else if (state is UnauthenticatedState) {
      return const AuthScreen();
    } else if (state is UnactiveAccount) {
      return const WaitingActiveProviderScreen();
    } else if (state is AuthenticatedUserState) {
      return const HomePage();
    } else if (state is AuthenticatedProviderState) {
      return const HomeProviderPage();
    } else {
      return const WelcomeScreen();
    }
  }
}
