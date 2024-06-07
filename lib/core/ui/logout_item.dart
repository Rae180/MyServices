import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/ui/app_dialog.dart';
import 'package:start/core/ui/profile_item.dart';
import 'package:start/features/Auth/bloc/auth_bloc.dart';


class LogOutItem extends StatelessWidget {
  const LogOutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
        icon: Boxicons.bx_log_out,
        text: AppLocalizations.of(context)?.logout ?? "",
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogItem(
                icon: Icon(
                  Boxicons.bx_log_out,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                title: AppLocalizations.of(context)?.logout ?? "",
                paragraph:
                    AppLocalizations.of(context)?.doYouWantToLogout ?? "",
                cancelButtonText: AppLocalizations.of(context)?.cancel ?? "",
                nextButtonText: AppLocalizations.of(context)?.logout ?? "",
                nextButtonFunction: () async {
                 // PreferenceUtils.setBool('isonline', false);
                  BlocProvider.of<AuthBloc>(context)
                      .add(LogOutEvent());
                   
                  Navigator.pop(context);
                },
                cancelButtonFunction: () {
                  Navigator.pop(context);
                },
              );
            },
             barrierDismissible: false,
          );
        });
  }
}
