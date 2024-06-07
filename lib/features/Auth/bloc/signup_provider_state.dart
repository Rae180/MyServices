part of 'signup_provider_bloc.dart';

class SignupProviderState {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String jobdescription;
  final String hourlyrate;
  final List<CategoryModel> categories;
  final List<ServiceModel> services;
  final String? gender;
  final CategoryModel? selectCategory;
  final ServiceModel? selectService;
  final String password;
  final String birthdaydate;
  final FormSubmissionState formSubmissionState;
  final bool showPassword;
  final bool showPassword1;
  const SignupProviderState(
      {required this.categories,
      required this.gender,
      required this.selectCategory,
      required this.selectService,
      required this.services,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.address,
      required this.jobdescription,
      required this.hourlyrate,
      required this.password,
      required this.formSubmissionState,
      required this.showPassword,
      required this.showPassword1,
      required this.birthdaydate});

  factory SignupProviderState.empty() {
    return const SignupProviderState(
        firstName: '',
        lastName: '',
        email: '',
        phone: '',
        address: '',
        jobdescription: '',
        hourlyrate: '',
        password: '',
        selectCategory: null,
        categories: [],
        selectService: null,
        services: [],
        gender: null,
        showPassword1: true,
        showPassword: true,
        birthdaydate: '',
        formSubmissionState: InitialFormState());
  }

  SignupProviderState copyWith(
      {String? firstName,
      String? lastName,
      String? email,
      String? phone,
      String? address,
      String? jobdescription,
      String? hourlyrate,
      List<CategoryModel>? categories,
      String? gender,
      String? birthdaydate,
      CategoryModel? selectCategory,
      List<ServiceModel>? services,
      ServiceModel? selectService,
      String? password,
      FormSubmissionState? formSubmissionState,
      bool? showPassword,
      bool? showPassword1}) {
    return SignupProviderState(
        categories: categories ?? this.categories,
        gender: gender ?? this.gender,
        selectCategory: selectCategory ?? this.selectCategory,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        jobdescription: jobdescription ?? this.jobdescription,
        hourlyrate: hourlyrate ?? this.hourlyrate,
        password: password ?? this.password,
        formSubmissionState: formSubmissionState ?? this.formSubmissionState,
        selectService: selectService ?? this.selectService,
        services: services ?? this.services,
        showPassword1: showPassword1 ?? this.showPassword1,
        showPassword: showPassword ?? this.showPassword,
        birthdaydate: birthdaydate ?? this.birthdaydate);
  }
}
