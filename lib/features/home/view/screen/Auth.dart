import 'package:flutter/material.dart';
import 'package:start/features/home/view/screen/Signup_Screen.dart';
import 'package:start/features/home/view/screen/Signup_Screen_Provider.dart';
import 'package:start/features/home/view/widgets/custom_TextFormField.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'Auth_screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onFieldSubmitted(String value) {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromARGB(255, 143, 201, 101),
                backgroundImage: AssetImage(
                  'C:/Users/Ali Hassn/Desktop/start/lib/features/assets/Sign in-pana.png',
                ),
              ),
              const Column(
                children: [
                  Text(
                    'ServiceConnect',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Find services providers effortlessy!',
                  )
                ],
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          '  Email',
                        ),
                      ],
                    ),
                    controller: emailController,
                    KeyboardTybe: TextInputType.emailAddress,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    label: const Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: Color.fromARGB(255, 143, 201, 101),
                        ),
                        Text(
                          '  Password',
                        ),
                      ],
                    ),
                    controller: passwordController,
                    KeyboardTybe: TextInputType.visiblePassword,
                    onFieldSubmitted: onFieldSubmitted,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ]),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 160,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 143, 201, 101),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Text('  OR  '),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'New here? join now!',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 143, 201, 101),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    },
                    child: const Text(
                      'Sign up As a User',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(
                          10,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 143, 201, 101),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SignupScreenProvider.routeName,
                      );
                    },
                    child: const Text(
                      'Sign up As a Provider',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
