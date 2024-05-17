import 'package:flutter/material.dart';
import 'package:start/features/home/view/screen/Auth.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = 'Welcome_Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
       const   Column(
            children: [
              Text(
                'Find Services',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Discover and book local service providers',
              ),
            ],
          ),
          Image.asset(
              'C:/Users/Ali Hassn/Desktop/start/lib/features/assets/Maintenance-cuate.png'),
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
            child: const Text(
              'Get Started',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
