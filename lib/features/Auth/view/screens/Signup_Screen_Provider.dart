import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:start/core/api_service/network_api_service_http.dart';
import 'package:start/core/ui/error_widget.dart';
import 'package:start/core/ui/loading_widget.dart';
import 'package:start/core/utils/helpers/form_submission_state.dart';
import 'package:start/features/Auth/bloc/signup_provider_bloc.dart';
import 'package:start/features/Auth/pickers/user_image_picker.dart';
import 'package:start/features/Auth/view/widgets/custom_TextFormField.dart';
import 'package:start/features/home/home_bloc/Category_bloc/category_bloc.dart';
import 'package:start/features/home/home_bloc/service_bloc/service_bloc.dart';
import 'package:start/features/home/model/category_model.dart';
import 'package:start/features/home/model/service_model.dart';
import 'package:start/features/home_provider/view/screens/home_provider_screen.dart';

class SignupScreenProvider extends StatefulWidget {
  static const routeName = 'Signup_Screen_Provider';
  const SignupScreenProvider({super.key});

  @override
  State<SignupScreenProvider> createState() => _SignupScreenProviderState();
}

class _SignupScreenProviderState extends State<SignupScreenProvider> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController REpasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController hourlyController = TextEditingController();

  File? userimageFile;
  void pickedImage(File pickedImage) {
    userimageFile = pickedImage;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    REpasswordController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryBloc(client: NetworkApiServiceHttp())..add(GetCategory()),
        ),
        BlocProvider(
          create: (context) => ServiceBloc(client: NetworkApiServiceHttp()),
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: const Color.fromARGB(255, 242, 255, 241),

            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.white,
                Color(0x008fc965),
              ])),
            ),
            // backgroundColor: const Color.fromARGB(255, 242, 255, 241),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color.fromARGB(255, 242, 255, 241),
                statusBarIconBrightness: Brightness.dark),
          ),
          body: BlocConsumer<SignupProviderBloc, SignupProviderState>(
            listener: (context, state) {
              if (state.formSubmissionState is FormSuccesfulState) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeProviderPage.routeName, (route) => false);
              } else if (state.formSubmissionState is FormNoInternetState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('No Internet'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ));
              } else if (state.formSubmissionState is FormNetworkErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      (state.formSubmissionState as FormNetworkErrorState)
                          .message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ));
                return;
              }
            },
            builder: (context, statesign) {
              if (statesign.formSubmissionState is SelectCategory) {
                BlocProvider.of<ServiceBloc>(context)
                    .add(GetServices(id: statesign.selectCategory!.id!));
              }
              return BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is LoadingCategory) {
                    return const LoadingWidget();
                  } else if (state is ErrorGetCategory) {
                    return NetworkErrorWidget(
                        message: state.message,
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context)
                              .add(GetCategory());
                        });
                  } else if (state is LoadedCategory) {
                    BlocProvider.of<SignupProviderBloc>(context)
                        .add(AddCategoriesevent(categories: state.categories));
     
                    return Container(
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
                                  backgroundColor:
                                      Color.fromARGB(255, 143, 201, 101),
                                  backgroundImage: AssetImage(
                                    'assets/Sign in-pana.png',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .joinnowtogetstarted,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(AppLocalizations.of(context)!
                                    .createanewaccounttoconnectwithcustomers),
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
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .firstname,
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
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .lastname,
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
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
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
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .phonenumber,
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
                                    obscuretext: statesign.showPassword,
                                    widget: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<SignupProviderBloc>(
                                                  context)
                                              .add(ShowPasswordevent(
                                                  value:
                                                      !statesign.showPassword));
                                        },
                                        icon: Icon(statesign.showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    label: Row(
                                      children: [
                                        const Icon(
                                          Icons.lock_outline,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .password,
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
                                    obscuretext: statesign.showPassword1,
                                    widget: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<SignupProviderBloc>(
                                                  context)
                                              .add(ShowRePasswordevent(
                                                  value: !statesign
                                                      .showPassword1));
                                        },
                                        icon: Icon(statesign.showPassword1
                                            ? Icons.visibility
                                            : Icons.visibility_off)),
                                    label: Row(
                                      children: [
                                        const Icon(
                                          Icons.password_outlined,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .confirmpassword,
                                        ),
                                      ],
                                    ),
                                    controller: REpasswordController,
                                    KeyboardTybe: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    validatoruser: (value) {
                                      if (value.toString().isEmpty ||
                                          value.toString() !=
                                              passwordController.text) {
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
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
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
                                _buildDatetime(context, statesign),
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
                                        color:
                                            const Color.fromARGB(14, 0, 0, 0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 20,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        validator: (value) {
                                          if (value.toString().isEmpty ||
                                              value == null) {
                                            return AppLocalizations.of(context)!
                                                .pleaseentergender;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        value: statesign.gender,
                                        hint: Text(
                                          AppLocalizations.of(context)!
                                              .selectgender,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: (String? newValue) {
                                          BlocProvider.of<SignupProviderBloc>(
                                                  context)
                                              .add(SelectGenderevent(
                                                  gender: newValue!));

                                          print(statesign.gender);
                                        },
                                        items: <Map<String, dynamic>>[
                                          {
                                            "id": 0,
                                            "value":
                                                AppLocalizations.of(context)!
                                                    .male,
                                          },
                                          {
                                            "id": 1,
                                            "value":
                                                AppLocalizations.of(context)!
                                                    .female,
                                          }
                                        ].map((Map value) {
                                          return DropdownMenuItem<String>(
                                            value: value['id'].toString(),
                                            child: Text(value['value']),
                                          );
                                        }).toList(),
                                      )),
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
                                    child: DropdownButtonFormField<
                                            CategoryModel>(
                                        validator: (value) {
                                          if (value.toString().isEmpty ||
                                              value == null) {
                                            return AppLocalizations.of(context)!
                                                .pleaseentercategory;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        value: statesign.selectCategory,
                                        hint: Text(
                                          AppLocalizations.of(context)!
                                              .selectcategory,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: (CategoryModel? newValue) {
                                          BlocProvider.of<SignupProviderBloc>(
                                                  context)
                                              .add(SelectCategoryevent(
                                                  category: newValue!));
                                        },
                                        items: state.categories
                                            .map((e) =>
                                                DropdownMenuItem<CategoryModel>(
                                                  value: e,
                                                  child: Text(e.name!),
                                                ))
                                            .toList()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BlocBuilder<ServiceBloc, ServiceState>(
                                  builder: (context, state) {
                                    if (state is LoadedServices) {
                                      BlocProvider.of<SignupProviderBloc>(
                                              context)
                                          .add(AddServicesevent(
                                              services: state.services));
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color:
                                              const Color.fromARGB(14, 0, 0, 0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 20,
                                        ),
                                        child: DropdownButtonFormField<
                                                ServiceModel>(
                                            validator: (value) {
                                              if (value.toString().isEmpty ||
                                                  value == null) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterservice;
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            value: statesign.selectService,
                                            hint: Text(
                                              AppLocalizations.of(context)!
                                                  .selectservice,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromARGB(
                                                  255, 143, 201, 101),
                                            ),
                                            elevation: 16,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            onChanged:
                                                (ServiceModel? newValue) {
                                              
                                              BlocProvider.of<
                                                          SignupProviderBloc>(
                                                      context)
                                                  .add(SelectServiceevent(
                                                      service: newValue!));
                                            },
                                            items: statesign.services
                                                .map((e) => DropdownMenuItem<
                                                        ServiceModel>(
                                                      value: e,
                                                      child: Text(e.name!),
                                                    ))
                                                .toList()),
                                      ),
                                    );
                                  },
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
                                          Icons.description,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .jobdescription,
                                        ),
                                      ],
                                    ),
                                    controller: jobController,
                                    KeyboardTybe: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    validatoruser: (value) {
                                      if (value.toString().isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseenterthejobdescription;
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
                                          Icons.attach_money_outlined,
                                          color: Color.fromARGB(
                                              255, 143, 201, 101),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .hourlyrate,
                                        ),
                                      ],
                                    ),
                                    controller: hourlyController,
                                    KeyboardTybe: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    validatoruser: (value) {
                                      if (value.toString().isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseenterthehourlyrate;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                          horizontal: 120,
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 143, 201, 101),
                                      ),
                                    ),
                                    onPressed: () {
                                      final bool? isValid =
                                          formKey.currentState?.validate();
                                      FocusScope.of(context).unfocus();

                                      if (statesign.birthdaydate.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .pleaseselectbirthdaydate),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ));
                                        return;
                                      } else if (userimageFile == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .pleasepickanimage),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ));
                                        return;
                                      } else if (isValid!) {
                                        formKey.currentState!.save();
                                        BlocProvider.of<
                                                SignupProviderBloc>(context)
                                            .add(SubmitSignupProviderevent(
                                                userimageFile: userimageFile!,
                                                firstName: firstNameController.text
                                                    .trim(),
                                                lastName:
                                                    lastNameController
                                                        .text
                                                        .trim(),
                                                email: emailController
                                                    .text
                                                    .trim(),
                                                phoneNumber:
                                                    phoneNumberController
                                                        .text
                                                        .trim(),
                                                password:
                                                    passwordController
                                                        .text
                                                        .trim(),
                                                REpassword:
                                                    REpasswordController
                                                        .text
                                                        .trim(),
                                                address: addressController.text
                                                    .trim(),
                                                job: jobController.text.trim(),
                                                hourly: hourlyController.text
                                                    .trim()));
                                      }
                                    },
                                    child: statesign.formSubmissionState
                                            is FormSubmittingState
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .signup,
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
                    );
                  } else {
                    return NetworkErrorWidget(
                        message: AppLocalizations.of(context)!.tryagain,
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context)
                              .add(GetCategory());
                        });
                  }
                },
              );
            },
          )),
    );
  }

  Widget _buildDatetime(BuildContext context, SignupProviderState state) {
    return InkWell(
      onTap: () async {
        pickeddaterange(context);
      },
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.birthdaydate.isEmpty
                  ? AppLocalizations.of(context)!.birthdaydate
                  : state.birthdaydate,
              style: const TextStyle(color: Colors.black87),
            ),
            const Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }

  Future pickeddaterange(
    BuildContext ctx,
  ) async {
    DateTime? newdateTimeRange = await showDatePicker(
        initialDate: DateTime(2000, 1, 1),
        context: context,
        firstDate: DateTime(1970),
        lastDate: DateTime(2010));

    if (newdateTimeRange == null) return;
    BlocProvider.of<SignupProviderBloc>(context).add(Selectbirthdayevent(
        birthday:
            DateFormat('yyyy-MM-dd').format(newdateTimeRange).toString()));
  }
}
