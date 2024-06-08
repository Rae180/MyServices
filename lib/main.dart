import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/config/routes/app_router.dart';
import 'package:start/core/locator/service_locator.dart';
import 'package:start/core/ui/notification_dialog.dart';
import 'package:start/core/utils/services/shared_preferences.dart';
import 'package:start/features/app/my_app.dart';
import 'package:start/features/provider/order/view/screens/order_details_screen.dart';
import 'package:start/firebase_options.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> setupInteractMessage() async {
  // when app is terminated
  final initialMessage = FirebaseMessaging.instance;
  initialMessage.requestPermission();
  //when app ins background
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (event.data['type'] == 'New Request') {
      Navigator.of(navigatorKey.currentState!.context).pushNamed(
          OrderDetailsScreen.routeName,
          arguments: {'id': event.data['orderId'].toString()});
    }
  });
  FirebaseMessaging.onMessage.listen((message) {
    print("jajkdjkashdjk ${message.data.toString()}");
    if (message.data['type'] == 'New Request') {
      showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentState!.context,
          builder: (context) {
            return NotificationDialog(
              image: 'assets/new.gif',
              message: message.data['type'],
              button: AppLocalizations.of(context)!.show,
              ontap: () {
                Navigator.of(navigatorKey.currentState!.context)
                    .pushReplacementNamed(OrderDetailsScreen.routeName,
                        arguments: {'id': message.data['orderId'].toString()});
              },
            );
          });
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupInteractMessage();

  await PreferenceUtils.init();
  HttpOverrides.global = MyHttpOverrides();
  await setupLocator();
  runApp(MainApp(
    appRouter: AppRouter(),
  ));
}
