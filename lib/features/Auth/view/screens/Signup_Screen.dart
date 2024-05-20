import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/features/Auth/bloc/sign_up_user_bloc.dart';
import 'package:start/features/Auth/pickers/user_image_picker.dart';
import 'package:start/features/Auth/view/widgets/custom_TextFormField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:start/features/home/view/screen/home.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = 'SignupScreen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController? firstNameController = TextEditingController();
  final TextEditingController? lastNameController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final TextEditingController? phoneNumberController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? REpasswordController = TextEditingController();
  final TextEditingController? addressController = TextEditingController();
  String? SelectedGender;
  File? userimageFile;
  bool show = true; 
  bool show1 = true; 
  void pickedImage(File pickedImage) {
    userimageFile = pickedImage;
  }

  @override
  void dispose() {
    firstNameController?.dispose();
    lastNameController?.dispose();
    emailController?.dispose();
    phoneNumberController?.dispose();
    passwordController?.dispose();
    REpasswordController?.dispose();
    addressController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpUserBloc(client: NetworkApiServiceHttp()),
      child: BlocConsumer<SignUpUserBloc, SignUpUserState>(
        listener: (context, state) {
          if (state is SuccessSignUpState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
          }
          if (state is ErrorSignUpState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          if (state is ShowPasswordstate) {
            show=!show;
          }
          if (state is ShowRePasswordstate) {
            show1=!show1;
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.white,
                  Color(0x008fc965),
                ])),
              ),
              backgroundColor: const Color.fromARGB(255, 242, 255, 241),
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Color.fromARGB(255, 242, 255, 241),
                  statusBarIconBrightness: Brightness.dark),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Color(0x008fc965),
                  ],
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundColor: Color.fromARGB(255, 143, 201, 101),
                          backgroundImage: AssetImage(
                            'assets/Sign in-pana.png',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.joinnowtogetstarted,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(AppLocalizations.of(context)!
                            .createanewaccounttoconnectwithproviders),
                        const SizedBox(
                          height: 40,
                        ),
                        UserImagePicker(imagepickfn: pickedImage),
                        const Padding(padding: EdgeInsets.all(10)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.person_2_outlined,
                                  color: Color.fromARGB(255, 143, 201, 101),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.firstname,
                                  style: const TextStyle(),
                                )
                              ],
                            ),
                            controller: firstNameController,
                            KeyboardTybe: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenteryourfirstname;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.person_2_outlined,
                                  color: Color.fromARGB(255, 143, 201, 101),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.lastname,
                                ),
                              ],
                            ),
                            controller: lastNameController,
                            KeyboardTybe: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenteryourlastname;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                )
                              ],
                            ),
                            controller: emailController,
                            KeyboardTybe: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty ||
                                  !value.toString().contains('@') ||
                                  !value.toString().contains('.')) {
                                return AppLocalizations.of(context)!
                                    .pleaseentertheemailcontaining;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.phone_outlined,
                                  color: Color.fromARGB(255, 143, 201, 101),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.phonenumber,
                                ),
                              ],
                            ),
                            controller: phoneNumberController,
                            KeyboardTybe: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty ||
                                  value.toString().length < 9 ||
                                  value.toString().length > 10) {
                                return AppLocalizations.of(context)!
                                    .itshouldconsistofordigits;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            obscuretext: show,
                            widget: IconButton(
                            onPressed: () {
                              BlocProvider.of<SignUpUserBloc>(context)
                                  .add(ShowPasswordevent());
                            },
                            icon: Icon(show
                                ? Icons.visibility
                                : Icons.visibility_off)),
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
                            KeyboardTybe: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty ||
                                  value.toString().length < 8) {
                                return AppLocalizations.of(context)!
                                    .itmustbecomposedofcharacters;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            obscuretext: show1,
                            widget: IconButton(
                            onPressed: () {
                              BlocProvider.of<SignUpUserBloc>(context)
                                  .add(ShowRePasswordevent());
                            },
                            icon: Icon(show
                                ? Icons.visibility
                                : Icons.visibility_off)),
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.password_outlined,
                                  color: Color.fromARGB(255, 143, 201, 101),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.confirmpassword,
                                ),
                              ],
                            ),
                            controller: REpasswordController,
                            KeyboardTybe: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty ||
                                  value.toString() !=
                                      passwordController!.text) {
                                return AppLocalizations.of(context)!
                                    .thereisnomatch;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            label: Row(
                              children: [
                                const Icon(
                                  Icons.location_city_outlined,
                                  color: Color.fromARGB(255, 143, 201, 101),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.address,
                                ),
                              ],
                            ),
                            controller: addressController,
                            KeyboardTybe: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validatoruser: (value) {
                              if (value.toString().isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseentertheaddress;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: const Color.fromARGB(14, 0, 0, 0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 20,
                            ),
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value.toString().isEmpty || value == null) {
                                  return AppLocalizations.of(context)!
                                      .pleaseentergender;
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              value: SelectedGender,
                              hint: Text(
                                AppLocalizations.of(context)!.selectgender,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 143, 201, 101),
                              ),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  print(newValue);
                                  SelectedGender = newValue;
                                });
                              },
                              items: <Map<String, dynamic>>[
                                {
                                  "id": 0,
                                  "value": AppLocalizations.of(context)!.male,
                                },
                                {
                                  "id": 1,
                                  "value": AppLocalizations.of(context)!.female,
                                }
                              ].map((Map value) {
                                return DropdownMenuItem<String>(
                                  value: value['id'].toString(),
                                  child: Text(value['value']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 120,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 143, 201, 101),
                              ),
                            ),
                            onPressed: () {
                              final bool? isValid =
                                  formKey.currentState?.validate();
                              FocusScope.of(context).unfocus();

                              if (userimageFile == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text('Please pick an image'),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ));
                                return;
                              }
                              if (isValid!) {
                                formKey.currentState!.save();
                                BlocProvider.of<SignUpUserBloc>(context).add(
                                    SignUpUserevevnt(
                                        image: userimageFile!,
                                        firstName:
                                            firstNameController!.text.trim(),
                                        lastName:
                                            lastNameController!.text.trim(),
                                        email: emailController!.text.trim(),
                                        phoneNumber:
                                            phoneNumberController!.text.trim(),
                                        password:
                                            passwordController!.text.trim(),
                                        gender: SelectedGender == '0'
                                            ? 'male'
                                            : "female",
                                        cpassword:
                                            REpasswordController!.text.trim(),
                                        address:
                                            addressController!.text.trim()));
                              }
                            },
                            child: state is LoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.signup,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
   
}
