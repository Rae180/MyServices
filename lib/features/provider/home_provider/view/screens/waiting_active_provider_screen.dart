import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:start/core/ui/app_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitingActiveProviderScreen extends StatelessWidget {
  const WaitingActiveProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color.fromARGB(255, 143, 201, 101)],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(200))
                    
                    ),
                child: Image.asset(
                  'assets/waiting.jpg',

                  fit: BoxFit.fill,
                )),
            const SizedBox(
              height: 20,
            ),

           AppText(
            color: Colors.white,
            textAlign: TextAlign.center,
            fontSize: 35,
            AppLocalizations.of(context)!.activeaccount
           ) 
          ],
        ),
      ],
    ));
  }
}
