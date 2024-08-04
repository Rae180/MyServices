import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/ui/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/language_item.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/ui/logout_item.dart';
import 'package:start/features/provider/home_provider/view/screens/current_order.screen.dart';
import 'package:start/features/provider/home_provider/view/screens/working_screen.dart';
import 'package:start/features/provider/order/view/screens/filter_order_screen.dart';
import 'package:start/features/user/Orders/Orders_bloc/Order_Details/deatils_for_order_bloc.dart';

class CurrentHomeScreen extends StatefulWidget {
  const CurrentHomeScreen({super.key});

  @override
  State<CurrentHomeScreen> createState() => _CurrentHomeScreenState();
}

class _CurrentHomeScreenState extends State<CurrentHomeScreen> {
  @override
  void initState() {
    BlocProvider.of<DeatilsForOrderBloc>(context).add(FilterOrdersByStatus("in progress"));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                String? deviceToken =
                    await FirebaseMessaging.instance.getToken();

                print(deviceToken);
              },
              icon: const Icon(Icons.abc))
        ],
        centerTitle: true,
        title: AppText(
          AppLocalizations.of(context)!.home,
          fontSize: 25,
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogOutItem(),
            const LanguageItem(),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OrdersScreenProvider()));
                },
                child: const Text('order'))
          ],
        ),
      ),
      body: BlocBuilder<DeatilsForOrderBloc, DeatilsForOrderState>(
        builder: (context, state) {
          if (state is DeatilsForOrderLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is DeatilsForOrderLoaded) {
            return CurrentOrderScreen(id:state.orders[0].id!);
          } else if (state is DeatilsForOrderEmpty) {
            return const WorkingScreen();
          } else if (state is DetailsForOrderError) {
           
            final errorState = state;
            return Center(
              child: NetworkErrorWidget(
                message: errorState.message,
                onPressed: () {
                  BlocProvider.of<DeatilsForOrderBloc>(context)
                      .add(FilterOrdersByStatus("in progress"));
                },
              ),
            );
          } else {
            
            return Container();
          }
        },
      ),
    );
  }
}
