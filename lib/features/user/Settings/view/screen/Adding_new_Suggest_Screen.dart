// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/Settings/Settings_bloc/Addig_new_Suggest_bloc/bloc/adding_new_suggest_bloc.dart';

class AddingNewSuggestScreen extends StatelessWidget {
  static const String routeName = 'Adding_New_Suggest_Screen';

  const AddingNewSuggestScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController suggestController = TextEditingController();

    return BlocProvider(
      create: (context) =>
          AddingNewSuggestBloc(client: NetworkApiServiceHttp()),
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(AppLocalizations.of(context)!.addingNewSuggest),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.sharingThoughts,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: suggestController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.yoursuggest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(Icons.settings_suggest_outlined),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              BlocBuilder<AddingNewSuggestBloc, AddingNewSuggestState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      final suggestion = suggestController.text;
                      if (suggestion.isNotEmpty) {
                        BlocProvider.of<AddingNewSuggestBloc>(context)
                            .add(AddingNewSugestSend(suggest: suggestion));
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: Text(AppLocalizations.of(context)!.sendingSuggest),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
