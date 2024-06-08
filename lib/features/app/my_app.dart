import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/config/routes/app_router.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/managers/theme_manager.dart';
import 'package:start/features/Auth/bloc/auth_bloc.dart';
import 'package:start/features/Auth/bloc/login_bloc.dart';
import 'package:start/features/Auth/bloc/signup_provider_bloc.dart';
import 'package:start/features/Auth/view/screens/Auth.dart';
import 'package:start/features/app_wrapper/app_wrapper.dart';
import 'package:start/features/provider/home_provider/bloc/home_provider_bloc.dart';
import 'package:start/features/provider/home_provider/bloc/submit_location_provider_bloc.dart';
import 'package:start/features/user/Orders/view/widgets/orders_ot_accepted_yet.dart';
import 'package:start/features/user/Providers/view/Screen/Providers_Screen.dart';
import 'package:start/features/user/home/view/screen/Services_scree.dart';
import 'package:start/features/user/home/view/screen/Welcome_screen.dart';
import 'package:start/features/user/home/view/screen/home.dart';
import 'package:start/features/localization/cubit/lacalization_cubit.dart';
import 'package:start/features/localization/localize_app_impl.dart';
import 'package:start/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainApp extends StatefulWidget {
  final AppRouter appRouter;
  const MainApp({super.key, required this.appRouter});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LacalizationCubit(
            LocalizeAppImpl(),
          )..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(client: NetworkApiServiceHttp())..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(client: NetworkApiServiceHttp()),
        ),
        BlocProvider(
          create: (context) =>
              SignupProviderBloc(client: NetworkApiServiceHttp()),
        ),
        BlocProvider(
          create: (context) => HomeProviderBloc(),
        ),
        BlocProvider(
          create: (context) =>
              SubmitLocationProviderBloc(client: NetworkApiServiceHttp()),
        )
      ],
      child: BlocBuilder<LacalizationCubit, LacalizationState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'APP',
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            darkTheme: darkTheme,
            theme: lightTheme,
            initialRoute: WelcomeScreen.routeName,
            onGenerateRoute: widget.appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
