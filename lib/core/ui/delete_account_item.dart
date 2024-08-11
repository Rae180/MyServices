import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/ui/app_dialog.dart';
import 'package:start/core/ui/loading_dialog.dart';
import 'package:start/core/ui/profile_item.dart';
import 'package:start/features/Auth/bloc/auth_bloc.dart';
import 'package:start/features/provider/profile/bloc/profile_bloc.dart';

class DeleteAccountItem extends StatelessWidget {
  const DeleteAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
        icon: Boxicons.bx_lock,
        text: AppLocalizations.of(context)?.deleteAccount ?? "",
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext cxt) {
              return DialogItem(
                    icon: Icon(
                      Boxicons.bx_log_out,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: AppLocalizations.of(context)?.deleteAccount ?? "",
                    paragraph: AppLocalizations.of(context)
                            ?.doYouWantToDeleteAccount ??
                        "",
                    cancelButtonText:
                        AppLocalizations.of(context)?.cancel ?? "",
                    nextButtonText: AppLocalizations.of(context)?.delete ?? "",
                    nextButtonFunction: () async {
                      BlocProvider.of<ProfileBloc>(context)
                          .add(DeleteAccountEvent());
                      
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


