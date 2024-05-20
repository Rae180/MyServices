import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/managers/languages_manager.dart';
import 'package:start/features/Auth/bloc/login_bloc.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen.dart';
import 'package:start/features/Auth/view/screens/Signup_Screen_Provider.dart';
import 'package:start/features/Auth/view/widgets/custom_TextFormField.dart';
import 'package:start/features/home/view/screen/home.dart';
import 'package:start/features/home_provider/view/screens/home_provider_screen.dart';
import 'package:start/features/localization/cubit/lacalization_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = 'Auth_screen';
  const AuthScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool show = true;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 255, 241),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            if (state.isprovider == 0) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (route) => false);
            } else if (state.isprovider == 1) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeProviderPage.routeName, (route) => false);
            }
          }
          if (state is ErrorLogingState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          if (state is ShowPasswordstate) {
            show = !show;
          }
          return Form(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Color.fromARGB(255, 143, 201, 101),
                    backgroundImage: AssetImage(
                      'assets/Sign in-pana.png',
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.serviceConnect,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .searchforproviderswithouteffort,
                      )
                    ],
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        label: Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: Color.fromARGB(255, 143, 201, 101),
                            ),
                            Text(
                              AppLocalizations.of(context)!.email,
                            ),
                          ],
                        ),
                        controller: emailController,
                        KeyboardTybe: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFormField(
                        obscuretext: show,
                        label: Row(
                          children: [
                            const Icon(
                              Icons.lock_outline,
                              color: Color.fromARGB(255, 143, 201, 101),
                            ),
                            Text(
                              AppLocalizations.of(context)!.password,
                            ),
                          ],
                        ),
                        controller: passwordController,
                        widget: IconButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(ShowPasswordevent());
                            },
                            icon: Icon(show
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        KeyboardTybe: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ]),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // padding: MaterialStateProperty.all(
                        //   const EdgeInsets.symmetric(
                        //     horizontal: 140,
                        //   ),
                        // ),
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 143, 201, 101),
                        ),
                      ),
                      onPressed: () {
                        BlocProvider.of<LoginBloc>(context).add(Loginevent(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()));
                      },
                      child: state is LoadingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLanguage(),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgetpassword,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 143, 201, 101),
                            ),
                          ))
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.or,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.newherejoinnow,
                    style: const TextStyle(
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
                        child: Text(
                          AppLocalizations.of(context)!.signupasauser,
                          style: const TextStyle(
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
                        child: Text(
                          AppLocalizations.of(context)!.signupasaprovider,
                          style: const TextStyle(
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
          );
        },
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
            child: Text(
              state.locale.languageCode == LanguagesManager.English
                  ? 'عربي'
                  : 'English',
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ]);
      },
    );
  }
}
