import 'package:flutter/material.dart';
import 'package:start/config/routes/app_router.dart';
import 'package:start/core/utils/services/shared_preferences.dart';
import 'package:start/features/app/my_app.dart';
import 'package:start/features/home/view/screen/Auth.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(MainApp(
    appRouter: AppRouter(),
  ));
}
