import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/managers/languages_manager.dart';
import 'package:start/features/Auth/view/screens/Auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/localization/cubit/lacalization_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'Welcome_Screen';

  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              _buildLanguage(),
              Text(
                AppLocalizations.of(context)!.findservices,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Text(
                AppLocalizations.of(context)!.discoverandbooklocalserviceproviders,
              ),
            ],
          ),
          Image.asset('assets/Maintenance-cuate.png'),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 143, 201, 101),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AuthScreen.routeName,
              );
            },
            child:  Text(
              AppLocalizations.of(context)!.getstarted,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLanguage() {
    return BlocBuilder<LacalizationCubit, LacalizationState>(
      builder: (context, state) {
        return Column(children: [
          TextButton(
            onPressed: () {
              BlocProvider.of<LacalizationCubit>(context).changeLanguage(
                  state.locale.languageCode == LanguagesManager.Arabic
                      ? LanguagesManager.English
                      : LanguagesManager.Arabic);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  
                  state.locale.languageCode == LanguagesManager.English
                      ? 'عربي'
                      : 'English',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          )
        ]);
      },
    );
  }
}
