import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/config/routes/app_router.dart';
import 'package:start/core/locator/service_locator.dart';
import 'package:start/core/ui/notification_dialog.dart';
import 'package:start/core/utils/services/shared_preferences.dart';
import 'package:start/features/app/my_app.dart';
import 'package:start/features/provider/order/view/screens/order_details_provider_screen.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';
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
    if (event.data['type'] == 'New Order' ||event.data['type'] == 'Reschedule Order') {
      Navigator.of(navigatorKey.currentState!.context)
          .pushNamed(OrderDetailsProviderScreen.routeName, arguments: {
        'id': event.data['orderId'].toString()
      }).then((value) => BlocProvider.of<DeatilsForOrderBloc>(
                  navigatorKey.currentState!.context)
              .add(FilterOrdersByStatus("in progress")));
    }
  });
  FirebaseMessaging.onMessage.listen((message) {
    print(message.data.toString());
    if (message.data['type'] == 'New Order' ||message.data['type'] == 'Reschedule Order' ) {
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
                    .pushReplacementNamed(OrderDetailsProviderScreen.routeName,
                        arguments: {
                      'id': message.data['orderId'].toString()
                    }).then((value) => BlocProvider.of<DeatilsForOrderBloc>(
                            navigatorKey.currentState!.context)
                        .add(FilterOrdersByStatus("in progress")));
              },
            );
          });
    } else {
      showDialog(
          barrierDismissible: false,
          context: navigatorKey.currentState!.context,
          builder: (context) {
            return NotificationDialog(
              // image: 'assets/new.gif',
              message: message.notification!.title!,
              button: AppLocalizations.of(context)!.ok,
              ontap: () {
                Navigator.of(context).pop();
                // Navigator.of(navigatorKey.currentState!.context)
                //     .pushReplacementNamed(OrderDetailsProviderScreen.routeName,
                //         arguments: {'id': message.data['orderId'].toString()});
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
