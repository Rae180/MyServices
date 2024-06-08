import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/core/ui/language_item.dart';
import 'package:start/core/ui/logout_item.dart';
import 'package:start/features/provider/home_provider/bloc/go_online_bloc.dart';
import 'package:start/features/provider/home_provider/bloc/submit_location_provider_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class WorkingScreen extends StatelessWidget {
  const WorkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoOnlineBloc(client: NetworkApiServiceHttp()),
      child: Scaffold(
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
        drawer: const Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogOutItem(),
              LanguageItem(),
            ],
          ),
        ),
        body: BlocBuilder<GoOnlineBloc, GoOnlineState>(
          builder: (context, state) {
            if (state.isOnline) {
              BlocProvider.of<SubmitLocationProviderBloc>(context)
                  .add(StartSubmittingLocation());
            } else {
              print("object");
              BlocProvider.of<SubmitLocationProviderBloc>(context)
                  .add(StopSubmittingLocation());
            }
            print(state.isOnline);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state.isOnline)
                  Expanded(
                    child: Lottie.asset(
                      'assets/Animation.json',
                    ),
                  ),
                if (!state.isOnline)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppText(
                        AppLocalizations.of(context)!
                            .makeSureYouReadyForServices,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          AppText(
                            AppLocalizations.of(context)?.chargedPhoneMessage ??
                                "",
                          ),
                        ],
                      ),
                    ],
                  ),
                if (state.isOnline)
                  Container(
                    margin: const EdgeInsets.only(left: 26, right: 26),
                    child: AppText(
                      AppLocalizations.of(context)?.stopServiceMessage ?? "",
                      textAlign: TextAlign.center,
                    ),
                  ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<GoOnlineBloc>(context)
                          .add(ChangeOnlineEvent());
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Color.fromARGB(255, 143, 201, 101)
                          ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        child: state.providerOnlineState ==
                                ProviderOnlineState.loading
                            ? const SpinKitCircle(
                                color: Color.fromARGB(255, 143, 201, 101),
                              )
                            : AppText(
                                state.isOnline
                                    ? AppLocalizations.of(context)!.stopwork
                                    : AppLocalizations.of(context)!.startWork,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontStyle: FontStyle.italic),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ));
          },
        ),
      ),
    );
  }
}
