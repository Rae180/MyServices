import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/Settings/Settings_bloc/Addig_new_Suggest_bloc/bloc/adding_new_suggest_bloc.dart';
import 'package:start/features/user/Settings/view/screen/Adding_new_Suggest_Screen.dart';
import 'package:start/features/user/Settings/view/widgets/Setting_Tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddingNewSuggestBloc(client: NetworkApiServiceHttp()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              title: Text(AppLocalizations.of(context)!.settings),
            ),
            body: ListView(
              children: [
                SettingTile(
                  icon: Icons.add,
                  title: AppLocalizations.of(context)!.addingNewSuggest,
                  onTap: () {
                    final addingnewsuggest =
                        BlocProvider.of<AddingNewSuggestBloc>(context);
                    Navigator.of(context)
                        .pushNamed(AddingNewSuggestScreen.routeName,arguments: addingnewsuggest);
                  },
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
