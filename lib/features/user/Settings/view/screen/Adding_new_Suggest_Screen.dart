// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/user/Settings/Settings_bloc/Addig_new_Suggest_bloc/bloc/adding_new_suggest_bloc.dart';

class AddingNewSuggestScreen extends StatelessWidget {
  static const String routeName = 'Adding_New_Suggest_Screen';
  final AddingNewSuggestBloc addingNewSuggestBloc;

  const AddingNewSuggestScreen({
    Key? key,
    required this.addingNewSuggestBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _suggestController = TextEditingController();

    return BlocProvider.value(
      value: addingNewSuggestBloc,
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _suggestController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.yoursuggest,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.settings_suggest_outlined),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final suggestion = _suggestController.text;
                  if (suggestion.isNotEmpty) {
                    // BlocProvider.of<AddingNewSuggestBloc>(context)
                    //     .add(AddingNewSugestSend(suggest: suggestion));
                    addingNewSuggestBloc
                        .add(AddingNewSugestSend(suggest: suggestion));
                  }
                },
                child: Text(AppLocalizations.of(context)!.sendingSuggest),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
