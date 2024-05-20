part of 'signup_provider_bloc.dart';

sealed class SignupProviderEvent {
  const SignupProviderEvent();
}

class AddCategoriesevent extends SignupProviderEvent {
  List<CategoryModel> categories;
  AddCategoriesevent({
    required this.categories,
  });
}

class SelectCategoryevent extends SignupProviderEvent {
  CategoryModel category;
  SelectCategoryevent({
    required this.category,
  });
}

class AddServicesevent extends SignupProviderEvent {
  List<ServiceModel> services;
  AddServicesevent({
    required this.services,
  });
}

class SelectServiceevent extends SignupProviderEvent {
  ServiceModel service;
  SelectServiceevent({
    required this.service,
  });
}

class SelectGenderevent extends SignupProviderEvent {
  final String gender;

  SelectGenderevent({required this.gender});
}

class Selectbirthdayevent extends SignupProviderEvent {
  final String birthday;

  Selectbirthdayevent({required this.birthday});
}

class ShowPasswordevent extends SignupProviderEvent {
  final bool value;

  ShowPasswordevent({required this.value});
}

class ShowRePasswordevent extends SignupProviderEvent {
  final bool value;

  ShowRePasswordevent({required this.value});
}

class SubmitSignupProviderevent extends SignupProviderEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String REpassword;
  final String address;
  final String job;
  final String hourly;
  final File userimageFile;

  SubmitSignupProviderevent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.REpassword,
      required this.address,
      required this.job,
      required this.hourly,
      required this.userimageFile});
}
